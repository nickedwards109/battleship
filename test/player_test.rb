require 'minitest/autorun'
require './lib/cell'
require './lib/player'

class TestPlayer < Minitest::Test
  def test_player_can_shoot
    empty_ai_grid = Grid.new
    ai_grid = empty_ai_grid.populate_grid
    ai_grid[0][0].is_ship = true
    ai_grid[0][1].is_ship = false
    player = Player.new
    player.fire("A1", ai_grid)
    player.fire("A2", ai_grid)
    assert_equal "H", ai_grid[0][0].status
    assert_equal "M", ai_grid[0][1].status
  end

  def test_player_wins
    empty_ai_grid = Grid.new
    ai_grid = empty_ai_grid.populate_grid
    ai_grid[0][0].is_ship = true
    ai_grid[0][1].is_ship = true
    ai_grid[1][0].is_ship = true
    ai_grid[1][1].is_ship = true
    ai_grid[1][2].is_ship = true
    player.fire("A1", ai_grid)
    player.fire("A2", ai_grid)
    player.fire("B1", ai_grid)
    player.fire("B2", ai_grid)
    
    assert_output(/You sunk all of the AI's ships! Nice work, sailor.\n/) {
      player.fire("B3", ai_grid)
    }
  end
end