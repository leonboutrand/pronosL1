require 'open-uri'

class FootballScraper
  def initialize(matchday = Game.current_matchday)
    @matchday = matchday
    url = "https://www.lfp.fr/ligue1/calendrier_resultat?sai=102&jour=#{@matchday}"
    @doc = Nokogiri::HTML(open(url).read)
  end

  def process
    scores = scrap_scores # scrapping scores as [home, away, status]
    home = teams(scrap_home) # scrapping home teams
    scores.each_with_index do |score, i|
      game = Game.where(matchday: @matchday).find_by_team_home_id(home[i].id)
      game.update(score_home: score[0], score_away: score[1], status: score[2]) if game.status != 'finished'
      ScoresUpdater.new(game).process
    end
  end

  def initialize_teams
    (scrap_home + scrap_away).each { |team| string_to_team(team) }
  end

  def initialize_games
    (1..38).each do |matchday|
      sleep(2)
      puts "\nInitializing games for matchday #{matchday}\n"
      games = FootballScraper.new(matchday).process
      games.each do |game|
        game[:matchday] = matchday
        Game.create!(game)
        puts "Journée #{game[:matchday]}: #{game[:team_home].name} (#{game[:score_home]}) - #{game[:team_away].name} (#{game[:score_away]})"
      end
    end
  end

  private

  def string_to_team(string)
    Team.create!(name: string)
  end

  def teams(names)
    names.map { |name| Team.find_by_name(name) }
  end

  def scrap_scores # TODO: retrieve information about live or not
    @doc.search('.stats a').map do |score|
      if score.text.strip != '' # if the game is already finished
        score.text.strip.split(' - ').map(&:to_i) << 'finished'
      elsif score.attributes['href'].value.match?(/feuille/) # if the game is live (has 'feuille' on his url)
        scrap_inside(score.attributes['href'].value)
      else # if the game didn't started yet
        ['', '', 'open']
      end
    end
  end

  def scrap_inside(path)
    url = "https://www.lfp.fr/#{path}"
    inside = Nokogiri::HTML(open(url).read)
    inside.search('.buts').map { |x| x.text.strip.to_i } << 'live'
  end

  def scrap_home
    @doc.search('.domicile a').map { |team| team.text.strip }
  end

  def scrap_away
    @doc.search('.exterieur a').map { |team| team.text.strip }
  end
end
