require 'dispel'
require_relative 'ai'
require_relative 'game'
require_relative 'view'

Dispel::Screen.open do |screen|
  game = Game.new
  ai = Ai.new
  view = View.new(game)

  screen.draw(view.draw_screen)

  Dispel::Keyboard.output do |key|
    case key
    when :up then view.move(0,-1)
    when :down then view.move(0,1)
    when :right then view.move(1,0)
    when :left then view.move(-1,0)
    when :enter
      view.set
      ai.make_move(game)
    when "q" then break
    when "r"
      game = Game.new
      view = View.new(game)
    end
    screen.draw(view.draw_screen)
  end
end