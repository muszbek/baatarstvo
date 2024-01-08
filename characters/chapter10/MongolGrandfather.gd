extends "res://characters/Character.gd"

enum dialogue_states {ENTER, ONE, TWO, THREE, LOOP}

const DIALOGUE_ENTER = "res://dialogues/chapter_10/mongol_grandfather_enter.txt"
const DIALOGUE_1 = "res://dialogues/chapter_10/mongol_grandfather_1.txt"
const DIALOGUE_2 = "res://dialogues/chapter_10/mongol_grandfather_2.txt"
const DIALOGUE_3 = "res://dialogues/chapter_10/mongol_grandfather_3.txt"
const DIALOGUE_LOOP = "res://dialogues/chapter_10/mongol_grandfather_loop.txt"
signal tale_listened

func _ready():
	pass

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_ENTER
			speak()
		dialogue_states.ONE:
			json_resource = DIALOGUE_1
			speak()
			dialogue_state = dialogue_states.TWO
		dialogue_states.TWO:
			json_resource = DIALOGUE_2
			speak()
			dialogue_state = dialogue_states.THREE
		dialogue_states.THREE:
			json_resource = DIALOGUE_3
			speak()
			dialogue_state = dialogue_states.LOOP
			emit_signal("tale_listened")
		dialogue_states.LOOP:
			json_resource = DIALOGUE_LOOP
			speak()

func on_father_spoken():
	dialogue_state = dialogue_states.ONE
