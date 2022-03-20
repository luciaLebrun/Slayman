extends Control

onready var _hp_text = $HP


func hpUpdate(value):
	_hp_text.text = str(value)
