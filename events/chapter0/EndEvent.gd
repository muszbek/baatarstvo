extends "res://events/EventZone.gd"

signal chapter_finish_anim

onready var fullscreen_anim = get_tree().get_nodes_in_group("fullscreen_anim")[-1]

func _ready():
	var _err = connect("chapter_finish_anim", fullscreen_anim, "on_chapter_finish")
	
func _on_EventZone_area_entered(_area):
	trigger()

func trigger():
	if state == states.ACTIVE:
		state = states.TRIGGERED
		emit_signal("chapter_finish_anim")
