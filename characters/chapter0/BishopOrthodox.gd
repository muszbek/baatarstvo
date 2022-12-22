extends "res://characters/Character.gd"

enum dialogue_states {ENTER, LOOP}

const DIALOGUE_1 = "res://dialogues/chapter_0/bishop_orthodox_1.txt"
const DIALOGUE_LOOP = "res://dialogues/chapter_0/bishop_orthodox_loop.txt"
signal bishop_spoken

# Called when the node enters the scene tree for the first time.
func _ready():
	character_name = "bishop_orthodox"
	var aleksandr = get_tree().get_nodes_in_group("aleksandr")[-1]
	var _err = connect("bishop_spoken", aleksandr, "bishop_spoken")

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_1
			speak()
			dialogue_state = dialogue_states.LOOP
			emit_signal("bishop_spoken")
		dialogue_states.LOOP:
			json_resource = DIALOGUE_LOOP
			speak()
