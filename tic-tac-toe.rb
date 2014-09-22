require 'dispel'
require_relative 'lib/ai'
require_relative 'lib/game'
require_relative 'lib/view'

Dispel::Screen.open do |screen|
  game = Game.new
  ai = Ai.new(game)
  view = View.new(game)

  screen.draw(view.draw_screen)

  Dispel::Keyboard.output do |key|
    case key
    when :up then view.move(0,-1)
    when :down then view.move(0,1)
    when :right then view.move(1,0)
    when :left then view.move(-1,0)
    when :enter then ai.make_move if view.set
    when "q" then break
    when "r"
      game = Game.new
      view = View.new(game)
      ai = Ai.new(game)
    end
    screen.draw(view.draw_screen)
  end
end