extends "res://characters/Character.gd"

enum dialogue_states {ENTER, LEARN_NEWS, LET_GO}

const DIALOGUE_1_LOOP = "res://dialogues/chapter_3/father_1_loop.txt"
const DIALOGUE_2 = "res://dialogues/chapter_3/father_2.txt"
const DIALOGUE_2_LOOP = "res://dialogues/chapter_3/father_2_loop.txt"

signal father_let_go

func _ready():
	character_name = "father"

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_1_LOOP
			speak()
		dialogue_states.LEARN_NEWS:
			json_resource = DIALOGUE_2
			speak()
			dialogue_state = dialogue_states.LET_GO
			emit_signal("father_let_go")
		dialogue_states.LET_GO:
			json_resource = DIALOGUE_2_LOOP
			speak()

func on_kipchak_talked():
	dialogue_state = dialogue_states.LEARN_NEWS
