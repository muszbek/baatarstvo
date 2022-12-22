extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_0/bear_loop.txt"

func _ready():
	character_name = "bear"

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
