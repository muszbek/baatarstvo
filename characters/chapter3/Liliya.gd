extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_3/liliya_loop.txt"

func _ready():
	character_name = "liliya"

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
