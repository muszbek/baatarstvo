extends "res://characters/Character.gd"

enum dialogue_states {FIRST, SECOND, THIRD, LOOP}

const DIALOGUE_1 = "res://dialogues/chapter_6/civilian_sitting_1.txt"
const DIALOGUE_2 = "res://dialogues/chapter_6/civilian_sitting_2.txt"
const DIALOGUE_3 = "res://dialogues/chapter_6/civilian_sitting_3.txt"
const DIALOGUE_LOOP = "res://dialogues/chapter_6/civilian_sitting_loop.txt"
signal sitting_civilian_talked

func _ready():
	character_name = "civilian_sitting"

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.FIRST:
			json_resource = DIALOGUE_1
			speak()
			dialogue_state = dialogue_states.SECOND
			emit_signal("sitting_civilian_talked")
		dialogue_states.SECOND:
			json_resource = DIALOGUE_2
			speak()
			dialogue_state = dialogue_states.THIRD
		dialogue_states.THIRD:
			json_resource = DIALOGUE_3
			speak()
			dialogue_state = dialogue_states.LOOP
		dialogue_states.LOOP:
			json_resource = DIALOGUE_LOOP
			speak()
