extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_0/camel_loop.txt"

func _ready():
	character_name = "camel"

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
