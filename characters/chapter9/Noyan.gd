extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_9/noyan_end.txt"

func _ready():
	character_name = "noyan"

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
