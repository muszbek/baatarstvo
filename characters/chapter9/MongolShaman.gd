extends "res://characters/Character.gd"

enum dialogue_states {ENTER, LOOP}
const DIALOGUE_1 = "res://dialogues/chapter_9/mongol_shaman_1.txt"
const DIALOGUE_LOOP = "res://dialogues/chapter_9/mongol_shaman_loop.txt"

func _ready():
	character_name = "mongol_shaman"

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_1
			speak()
			dialogue_state = dialogue_states.LOOP
		dialogue_states.LOOP:
			json_resource = DIALOGUE_LOOP
			speak()
