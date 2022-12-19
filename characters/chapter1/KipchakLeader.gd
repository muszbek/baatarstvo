extends "res://characters/MeleeChar.gd"

enum dialogue_states {ENTER, LOOP}

const DIALOGUE_1 = "res://dialogues/chapter_2/kipchak_advisor_1.txt"
const DIALOGUE_LOOP = "res://dialogues/chapter_2/kipchak_advisor_loop.txt"

func _ready():
	character_name = "kipchak_advisor"
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_1
			speak()
			dialogue_state = dialogue_states.LOOP
		dialogue_states.LOOP:
			json_resource = DIALOGUE_LOOP
			speak()

func on_envoy_killed(): queue_free()
