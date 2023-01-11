extends "res://characters/MeleeChar.gd"

enum dialogue_states {ENTER, LOOP}

const DIALOGUE_1 = "res://dialogues/chapter_1/kipchak_leader_1.txt"
const DIALOGUE_LOOP = "res://dialogues/chapter_1/kipchak_leader_loop.txt"

onready var stanislav = get_tree().get_nodes_in_group("stanislav")[-1]

signal kipchak_spoken

func _ready():
	var _err = connect("kipchak_spoken", stanislav, "on_kipchak_spoken")
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_1
			speak()
			dialogue_state = dialogue_states.LOOP
			emit_signal("kipchak_spoken")
		dialogue_states.LOOP:
			json_resource = DIALOGUE_LOOP
			speak()
