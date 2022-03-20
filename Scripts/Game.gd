extends Node2D

onready var ui = $GUI/HPUI

func HPUpdate(value):
	ui.hpUpdate(value)
