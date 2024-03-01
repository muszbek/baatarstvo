extends "res://characters/Character.gd"

enum dialogue_states {ENTER, ONE, END}

const DIALOGUE_ENTER = "res://dialogues/chapter_11/arban_enter.txt"
const DIALOGUE_1 = "res://dialogues/chapter_11/arban_1.txt"
const DIALOGUE_END = "res://dialogues/chapter_11/arban_end.txt"
signal tale_listened

func _ready():
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_ENTER
			speak()
		dialogue_states.ONE:
			json_resource = DIALOGUE_1
			speak()
			dialogue_state = dialogue_states.END
		dialogue_states.END:
			json_resource = DIALOGUE_END
			speak()

func on_priest_spoken():
	dialogue_state = dialogue_states.ONE
