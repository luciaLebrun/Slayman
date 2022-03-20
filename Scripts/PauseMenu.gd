extends Control

var is_paused = false setget set_is_paused

onready var video_btn = $VBoxContainer/HBoxContainer/VideoBtn
onready var video_settings = $VBoxContainer/SettingsContainer/VideoSettings
onready var audio_settings = $VBoxContainer/SettingsContainer/AudioSettings
onready var controls_settings = $VBoxContainer/SettingsContainer/ControlsSettings

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		video_btn.grab_focus()
		self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


func _on_ResumeBtn_pressed():
	self.is_paused = false

func hideAll():
	video_settings.hide()
	audio_settings.hide()
	controls_settings.hide()

func _on_VideoBtn_pressed():
	hideAll()
	video_settings.show()

func _on_AudioBtn_pressed():
	hideAll()
	audio_settings.show()

func _on_ControlBtn_pressed():
	hideAll()
	controls_settings.show()

func _on_QuitBtn_pressed():
	get_tree().quit()
