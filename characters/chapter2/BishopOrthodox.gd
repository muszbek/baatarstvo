extends "res://characters/Character.gd"

enum dialogue_states {ENTER, ENVOY_KILLED, SENT_TO_BATTLE}

const DIALOGUE_1_LOOP = "res://dialogues/chapter_2/bishop_orthodox_1_loop.txt"
const DIALOGUE_2 = "res://dialogues/chapter_2/bishop_orthodox_2.txt"
const DIALOGUE_2_LOOP = "res://dialogues/chapter_2/bishop_orthodox_2_loop.txt"

onready var death_event_handler = get_tree().get_nodes_in_group("mongol_death_event")[-1]

signal ready_to_leave

func _ready():
	character_name = "bishop_orthodox"
	death_event_handler.connect("all_down", self, "on_envoy_killed")

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_1_LOOP
			speak()
		dialogue_states.ENVOY_KILLED:
			json_resource = DIALOGUE_2
			speak()
			dialogue_state = dialogue_states.SENT_TO_BATTLE
			emit_signal("ready_to_leave")
		dialogue_states.SENT_TO_BATTLE:
			json_resource = DIALOGUE_2_LOOP
			speak()

func on_envoy_killed(): dialogue_state = dialogue_states.ENVOY_KILLED
