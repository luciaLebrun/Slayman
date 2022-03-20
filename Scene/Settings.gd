extends Popup

onready var vsync = $VBoxContainer/VideoSettings/VSyncCheckbox
onready var fullScreen = $VBoxContainer/VideoSettings/FullScreenCheckbox

func _ready():
	vsync.pressed = OS.is_vsync_enabled()
	fullScreen.pressed = OS.window_fullscreen

func _on_VSyncCheckbox_toggled(button_pressed):
	OS.set_use_vsync(button_pressed)

func _on_FullScreenCheckbox_toggled(button_pressed):
	OS.set_window_fullscreen(button_pressed)
