extends "res://characters/Character.gd"

enum dialogue_states {FIRST, SECOND, THIRD, FOURTH, LOOP}

const DIALOGUE_1 = "res://dialogues/chapter_5/gravedigger_1.txt"
const DIALOGUE_2 = "res://dialogues/chapter_5/gravedigger_2.txt"
const DIALOGUE_3 = "res://dialogues/chapter_5/gravedigger_3.txt"
const DIALOGUE_4 = "res://dialogues/chapter_5/gravedigger_4.txt"
const DIALOGUE_LOOP = "res://dialogues/chapter_5/gravedigger_loop.txt"

func _ready():
	character_name = "gravedigger"

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.FIRST:
			json_resource = DIALOGUE_1
			speak()
			dialogue_state = dialogue_states.SECOND
		dialogue_states.SECOND:
			json_resource = DIALOGUE_2
			speak()
			dialogue_state = dialogue_states.THIRD
		dialogue_states.THIRD:
			json_resource = DIALOGUE_3
			speak()
			dialogue_state = dialogue_states.FOURTH
		dialogue_states.FOURTH:
			json_resource = DIALOGUE_4
			speak()
			dialogue_state = dialogue_states.LOOP
		dialogue_states.LOOP:
			json_resource = DIALOGUE_LOOP
			speak()
