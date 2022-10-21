extends "res://characters/MeleeChar.gd"

enum states {ENTER, WAITING, FOUGHT}

const DIALOGUE_ENTER = "res://dialogues/chapter_0/rus_training_1.txt"
const DIALOGUE_LOOP_FIGHT = "res://dialogues/chapter_0/rus_training_loop_1.txt"
const DIALOGUE_AFTER_FIGHT = "res://dialogues/chapter_0/rus_training_2.txt"
const DIALOGUE_LOOP_AFTER_FIGHT = "res://dialogues/chapter_0/rus_training_loop_2.txt"

func _ready():
	character_name = "rus_training"
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	match state:
		states.ENTER:
			json_resource = DIALOGUE_ENTER
			speak()
			state = states.WAITING
		states.WAITING:
			json_resource = DIALOGUE_LOOP_FIGHT
			speak()
		states.FOUGHT:
			json_resource = DIALOGUE_LOOP_AFTER_FIGHT
			speak()

func _on_Hurtbox_area_entered(_area):
	match state:
		states.WAITING:
			json_resource = DIALOGUE_AFTER_FIGHT
			speak()
			state = states.FOUGHT
