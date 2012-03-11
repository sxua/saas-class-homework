class WrongNumberOfPlayersError < StandardError; end
class NoSuchStrategyError < StandardError; end

def rps_game_winner game
  raise WrongNumberOfPlayersError if game.nil? || game.length != 2
  move1, move2 = game.map {|g| move = g.last.to_s.downcase; raise NoSuchStrategyError unless %w(r p s).include? move; move}
  return ((move1 == 'p' && move2 == 'r') || (move1 == 's' && move2 == 'p') || (move1 == 'r' && move2 == 's') || (move1 == move2)) ? game.first : game.last
end

def rps_tournament_winner tournament
  total = tournament.flatten.length
  return rps_game_winner(tournament) if total == 4
  level = (n = 1; n += 1 while (total >> n) > 0; n - 1) - 2
  players = tournament.flatten(level)
  players = players.each_slice(2).map {|game| rps_game_winner game} while players.length > 1
  players.first
end