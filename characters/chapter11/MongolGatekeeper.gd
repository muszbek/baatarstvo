extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_11/gatekeeper_loop.txt"

func _ready():
	character_name = "mongol_gatekeeper"
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
