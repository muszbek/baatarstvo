extends "res://characters/Character.gd"

enum dialogue_states {ENTER, LOOP, END}

const DIALOGUE_1 = "res://dialogues/chapter_10/mongol_father_1.txt"
const DIALOGUE_LOOP = "res://dialogues/chapter_10/mongol_father_loop.txt"
const DIALOGUE_END = "res://dialogues/chapter_10/mongol_father_end.txt"
signal father_spoken

func _ready():
	character_name = "mongol_father"
	var grandfather = get_tree().get_nodes_in_group("grandfather")[-1]
	var _err = connect("father_spoken", grandfather, "on_father_spoken")
	grandfather.connect("tale_listened", self, "on_tale_listened")

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_1
			speak()
			dialogue_state = dialogue_states.LOOP
			emit_signal("father_spoken")
		dialogue_states.LOOP:
			json_resource = DIALOGUE_LOOP
			speak()
		dialogue_states.END:
			json_resource = DIALOGUE_END
			speak()

func on_tale_listened():
	dialogue_state = dialogue_states.END
