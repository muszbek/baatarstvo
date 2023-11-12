extends "res://characters/Character.gd"

enum dialogue_states {ENTER, LOOP}

const DIALOGUE_1 = "res://dialogues/chapter_6/constable_1.txt"
const DIALOGUE_LOOP = "res://dialogues/chapter_6/constable_loop.txt"
signal allowed_in_castle

func _ready():
	character_name = "constable"

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_1
			speak()
			dialogue_state = dialogue_states.LOOP
			emit_signal("allowed_in_castle")
		dialogue_states.LOOP:
			json_resource = DIALOGUE_LOOP
			speak()
