extends "res://characters/RangedEnemy.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_11/mongol_naginata_fort_loop.txt"

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
