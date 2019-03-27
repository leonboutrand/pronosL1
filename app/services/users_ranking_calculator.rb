class UsersRankingCalculator
  def self.call
    User.all.each do |user|
      puts user.pseudo
      next if user.bets.empty?

      user.update(game_points: user.bets.map(&:points).select { |x| x }.reduce(:+) || 0)
    end
  end
end
