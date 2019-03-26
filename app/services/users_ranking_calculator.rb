class UsersRankingCalculator
  def self.call
    User.all.each do |user|
      puts user.pseudo
      next if user.bets.empty?

      user.update(game_points: user.bets.map(&:points).reduce(:+))
    end
  end
end
