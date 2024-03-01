extends "res://characters/Character.gd"

const DIALOGUE = "res://dialogues/chapter_12/altai_loop.txt"

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE
	speak()
