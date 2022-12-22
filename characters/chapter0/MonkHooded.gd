extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_0/monk_hooded_loop.txt"

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
