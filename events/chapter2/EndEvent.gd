extends "res://events/EventZone.gd"

const SCRIPT_NAME = "chapter_finish"

signal chapter_finish_anim

onready var fullscreen_anim = get_tree().get_nodes_in_group("fullscreen_anim")[-1]

func _ready():
	dialogue.connect("script", self, "handle_script")
	var _err = connect("chapter_finish_anim", fullscreen_anim, "on_chapter_finish")

func handle_script(script_name):
	if script_name == SCRIPT_NAME:
		emit_signal("chapter_finish_anim")
