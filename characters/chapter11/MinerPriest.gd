extends "res://characters/Character.gd"

enum dialogue_states {ENTER, LOOP}

const DIALOGUE_1 = "res://dialogues/chapter_11/miner_priest_1.txt"
const DIALOGUE_LOOP = "res://dialogues/chapter_11/miner_priest_loop.txt"
signal priest_spoken

func _ready():
	var arban = get_tree().get_nodes_in_group("mongol_arban")[-1]
	var _err = connect("priest_spoken", arban, "on_priest_spoken")
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_1
			speak()
			emit_signal("priest_spoken")
			dialogue_state = dialogue_states.LOOP
		dialogue_states.LOOP:
			json_resource = DIALOGUE_LOOP
			speak()
