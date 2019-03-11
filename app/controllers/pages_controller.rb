require 'open-uri'

class PagesController < ApplicationController
  def home
    @users = User.all
  end

  def live
    @scores = scraper(25, true)
  end

  def pronos
    @scores = scraper(27, false)
  end

  private

  def scraper(matchday, live)
    url = "https://www.lfp.fr/ligue1/calendrier_resultat?sai=102&jour=#{matchday}"
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    scores = scrap_scores(doc) if live
    home = scrap_home(doc)
    away = scrap_away(doc)
    games = []
    if live
      scores.each_with_index do |score, i|
        games << { home: home[i], score_home: score[0], score_away: score[1], away: away[i] }
      end
    else
      home.each_with_index do |_team, i|
        games << { home: home[i], away: away[i] }
      end
    end
    games
  end

  def scrap_scores(doc)
    results = []
    doc.search('.stats a').each do |score|
      if score.text.strip != ''
        results << score.text.strip.split(' - ').map { |x| x.to_i }
      elsif score.attributes['href'].value.match?(/feuille/)
        results << scrap_inside(score.attributes['href'].value)
      else
        results << 'Pas commencé'
      end
    end
    results
  end

  def scrap_inside(path)
    url = "https://www.lfp.fr/#{path}"
    inside = Nokogiri::HTML(open(url).read)
    inside.search('.buts').map { |x| x.text.strip.to_i }
  end

  def scrap_home(doc)
    results = []
    doc.search('.domicile a').each do |team|
      results << team.text.strip
    end
    results
  end

  def scrap_away(doc)
    results = []
    doc.search('.exterieur a').each do |team|
      results << team.text.strip
    end
    results
  end
end
