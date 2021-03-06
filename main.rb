# The setup for this is gonna be weird but i assure you it WILL work i think

require_relative 'luminol/system/system'
require_relative 'luminol/system/os'
require_relative 'luminol/scenes/scene_mapedit'
require_relative 'luminol/system/crashhandler'
require_relative 'luminol/system/cursor'

require_relative 'luminol/subscribers/resize'
require_relative 'luminol/subscribers/skin'
require_relative 'luminol/subscribers/window'
require_relative 'luminol/subscribers/project'

begin
  working_dir = File.expand_path('.')
  Font.default_name = 'Terminus (TTF)'
  $system = System.new
  $system.working_dir = working_dir

  $resizesignal = ResizeSignal.new
  $skinsignal = SkinSignal.new
  $windowsignal = WindowSignal.new
  $projectsignal = ProjectSignal.new

  Graphics.show_cursor = false

  $cursor = Cursor.new
  $luminol_os = OS.os

  Graphics.frame_rate = 120

  $scene = Scene_MapEdit.new
  while $scene != nil
    $scene.main
  end

  print 'Shutting down...'
rescue NoMemoryError, ScriptError, StandardError => error
  Crash_Handler.handle(error)
end
