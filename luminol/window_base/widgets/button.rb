require_relative 'widget'

class Button < Widget

  attr_accessor :state
  attr_accessor :disabled

  def initialize(rect, options = {})
    super(rect, options)
    @state = false

    @pressed_icon = options[:pressed_icon]
    @pressed_icon ||= $system.button(:pressed)
    @unpressed_icon = options[:unpressed_icon]
    @unpressed_icon ||= options[:released_icon]
    @unpressed_icon ||= $system.button(:unpressed)

    @disabled = options[:disabled]
    @disabled ||= false
  end

  def update(window)
    return unless super window
    return if @disabled

    if MKXP.mouse_in_window
      mx, my = get_mouse_pos window

      @selected = mouse_inside_widget?(window) # Check if mouse is in button

      if @selected
        if Input.trigger?(Input::MOUSELEFT)
          @state = !@state
          @block&.call(@state)
        end
      end
    else
      @selected = false
    end
  end

  def draw(bitmap)
    return unless super bitmap

    icon = if @state
             @pressed_icon
           else
             @unpressed_icon
           end
    opacity = @options[:opacity]
    opacity ||= 255

    bitmap.stretch_blt(@rect, icon, Rect.new(0, 0, icon.width, icon.height), opacity)
  end

  def on_click(&block)
    @block = block
  end
end
