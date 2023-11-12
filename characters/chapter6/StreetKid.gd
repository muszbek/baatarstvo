extends "res://characters/MovingChar.gd"

enum dialogue_states {ENTER, HELP_ESCAPE}

const DIALOGUE_1_LOOP = "res://dialogues/chapter_6/street_kid_loop_1.txt"
const DIALOGUE_2_LOOP = "res://dialogues/chapter_6/street_kid_loop_2.txt"
const KID_HELP_POS_TARGET_NAME = "kid_help_pos"

onready var kid_help_pos_target = get_tree().get_nodes_in_group(KID_HELP_POS_TARGET_NAME)[-1]

func _ready():
	character_name = "street_kid"
	var atabeg = get_tree().get_nodes_in_group("atabeg")[-1]
	atabeg.connect("atabeg_exited", self, "go_to_help_pos")
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_1_LOOP
			speak()
		dialogue_states.HELP_ESCAPE:
			json_resource = DIALOGUE_2_LOOP
			speak()

func go_to_help_pos():
	set_deferred("global_position", kid_help_pos_target.global_position)
	facing = directions.BACK
	idle_animate()
	dialogue_state = dialogue_states.HELP_ESCAPE
