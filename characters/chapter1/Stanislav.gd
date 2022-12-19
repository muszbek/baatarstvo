extends "res://characters/MeleeChar.gd"

enum states {START, SPOKEN, KIPCHAK_SPOKEN, LEAVE}

const DIALOGUE_TALK_TO_KIPCHAK = "res://dialogues/chapter_1/stanislav_1.txt"
const DIALOGUE_TALK_TO_KIPCHAK_LOOP = "res://dialogues/chapter_1/stanislav_1_loop.txt"
const DIALOGUE_LEAVE = "res://dialogues/chapter_1/stanislav_2.txt"
const DIALOGUE_LEAVE_LOOP = "res://dialogues/chapter_1/stanislav_2_loop.txt"
signal access_east
signal leave_horse

func _ready():
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	match state:
		states.START:
			json_resource = DIALOGUE_TALK_TO_KIPCHAK
			speak()
			emit_signal("access_east")
			state = states.SPOKEN
		states.SPOKEN:
			json_resource = DIALOGUE_TALK_TO_KIPCHAK_LOOP
			speak()
		states.KIPCHAK_SPOKEN:
			json_resource = DIALOGUE_LEAVE
			speak()
			emit_signal("leave_horse")
			state = states.LEAVE
		states.LEAVE:
			json_resource = DIALOGUE_LEAVE_LOOP
			speak()

func on_kipchak_spoken():
	state = states.KIPCHAK_SPOKEN
