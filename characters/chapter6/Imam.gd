extends "res://characters/Character.gd"

enum dialogue_states {FIRST, SECOND, LOOP}

const DIALOGUE_1 = "res://dialogues/chapter_6/imam_1.txt"
const DIALOGUE_2 = "res://dialogues/chapter_6/imam_2.txt"
const DIALOGUE_LOOP = "res://dialogues/chapter_6/imam_loop.txt"

func _ready():
	character_name = "imam"

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.FIRST:
			json_resource = DIALOGUE_1
			speak()
			dialogue_state = dialogue_states.SECOND
		dialogue_states.SECOND:
			json_resource = DIALOGUE_2
			speak()
			dialogue_state = dialogue_states.LOOP
		dialogue_states.LOOP:
			json_resource = DIALOGUE_LOOP
			speak()
