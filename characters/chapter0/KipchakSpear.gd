extends "res://characters/MeleeEnemy.gd"

const SCRIPT_NAME_1 = "become_alert"
const SCRIPT_NAME_2 = "become_hostile"

const DIALOGUE_1 = "res://dialogues/chapter_0/kipchak_1.txt"
const DIALOGUE_DEAD = "res://dialogues/chapter_0/kipchak_death.txt"
signal leader_death

onready var death_event_handler = get_tree().get_nodes_in_group("kipchak_death_event")[-1]
var timer: Timer

func _ready():
	character_name = "kipchak_spear"
	dialogue.connect("script", self, "handle_script")
	var _err = connect("death", death_event_handler, "on_kipchak_death")
	_err = connect("leader_death", death_event_handler, "on_leader_death")
	death_event_handler.connect("one_down", self, "on_one_down")
	death_event_handler.connect("all_down", self, "on_all_down")

func handle_script(script_name):
	match script_name:
		SCRIPT_NAME_1: become_alert()
		SCRIPT_NAME_2: become_hostile()

func become_alert():
	behavior = hostility.ALERT
	time_end_dialogue_signal()

func become_hostile():
	behavior = hostility.HOSTILE
	time_end_dialogue_signal()

func time_end_dialogue_signal():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.1
	timer.one_shot = true
	var _err = timer.connect("timeout", self, "dialogue_signal")
	timer.start()

func dialogue_signal():
	dialogue.emit_signal("next_line")
	timer.queue_free()

func on_one_down():
	match state:
		states.IDLE, states.TRACKING:
			json_resource = DIALOGUE_1
			speak()
		states.DEAD:
			emit_signal("leader_death")

func on_all_down():
	match state:
		states.DEAD:
			json_resource = DIALOGUE_DEAD
			speak()
