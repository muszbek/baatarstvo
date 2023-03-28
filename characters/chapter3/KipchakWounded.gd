extends "res://characters/Character.gd"

enum states {START, LOOP}

const DIALOGUE_1 = "res://dialogues/chapter_3/kipchak_wounded_1.txt"
const DIALOGUE_LOOP = "res://dialogues/chapter_3/kipchak_wounded_loop.txt"

onready var father = get_tree().get_nodes_in_group("father")[-1]
onready var stablemaster = get_tree().get_nodes_in_group("stablemaster")[-1]
signal kipchak_talked

func _ready():
	var _err = connect("kipchak_talked", father, "on_kipchak_talked")
	_err = connect("kipchak_talked", stablemaster, "on_kipchak_talked")
	idle_animate()
	state = states.START

func _on_Interactionbox_area_entered(_area):
	match state:
		states.START:
			json_resource = DIALOGUE_1
			speak()
			emit_signal("kipchak_talked")
			state = states.LOOP
		states.LOOP:
			json_resource = DIALOGUE_LOOP
			speak()
