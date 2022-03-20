extends Control

onready var start_btn = $VBoxContainer/StartBtn
onready var video_btn = $SettingsMenu/VBoxContainer/ButtonsContainer/VideoBtn
onready var options_btn = $VBoxContainer/OptionsBtn

onready var settings_menu = $SettingsMenu

onready var video_settings = $SettingsMenu/VBoxContainer/VideoSettings
onready var audio_settings = $SettingsMenu/VBoxContainer/AudioSettings
onready var controls_settings = $SettingsMenu/VBoxContainer/ControlsSettings

# Called when the node enters the scene tree for the first time.
func _ready():
	start_btn.grab_focus()


func _on_StartBtn_pressed():
	get_tree().change_scene("res://Scene/Game.tscn")


func _on_OptionsBtn_pressed():
	video_btn.grab_focus()
	settings_menu.popup_centered()


func _on_ExitBtn_pressed():
	get_tree().quit()


func _on_VideoBtn_pressed():
	hideAll()
	video_settings.show()


func _on_AudioBtn_pressed():
	hideAll()
	audio_settings.show()


func _on_ControlBtn3_pressed():
	hideAll()
	controls_settings.show()


func hideAll():
	video_settings.hide()
	audio_settings.hide()
	controls_settings.hide()

func _on_ReturnBtn_pressed():
	options_btn.grab_focus()
	settings_menu.hide()
