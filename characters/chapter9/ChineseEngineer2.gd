extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_9/chinese_engineer_2_loop.txt"

func _ready():
	pass

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
