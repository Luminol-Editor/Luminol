require_relative "../window_base/window_draggable"
require_relative "../window_base/draw_types/draw_types"
require_relative "../window_base/widgets/tonepicker"

class Scene_MapEdit
  def main
    # Setup Scene
    Graphics.transition(40)

    # Grab icon
    icon = Bitmap.new(16, 16)
    skin = $system.skin
    icon.blt(0, 0, skin, Rect.new(192, 80, 16, 16))

    @testwindow = Window_Draggable.new(0, 0, 240, 480, "Sound Test", icon)
    @testwindow.contents = Bitmap.new(@testwindow.width - 32, @testwindow.height - 32)

    @testwindow.add_widget(
      :color, TonePicker.new(Rect.new(0, 0, 200, 128))
    )

    @testwindow.draw

    loop do
      Graphics.update
      Input.update
      update

      break if $scene != self
    end

    dispose
    Graphics.freeze
  end

  def dispose
  end

  def update
    $system.update
    $cursor.update

    @testwindow.update
  end
end
