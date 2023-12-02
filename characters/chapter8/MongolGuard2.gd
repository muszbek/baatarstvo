extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_8/mongol_guard_2_loop.txt"

func _ready():
	pass

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
