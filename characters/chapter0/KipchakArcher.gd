extends "res://characters/RangedEnemy.gd"

const SCRIPT_NAME_1 = "shoot_aleksandr"
const SCRIPT_NAME_2 = "become_alert"
const SCRIPT_NAME_3 = "become_hostile"

onready var death_event_handler = get_tree().get_nodes_in_group("kipchak_death_event")[-1]

func _ready():
	dialogue.connect("script", self, "handle_script")
	var _err = connect("death", death_event_handler, "on_kipchak_death")
	death_event_handler.connect("leader_down", self, "on_leader_down")

func handle_script(script_name):
	match script_name:
		SCRIPT_NAME_1: shoot_aleksandr()
		SCRIPT_NAME_2: become_alert()
		SCRIPT_NAME_3: become_hostile()
		
	
func shoot_aleksandr():
	var aleksandr = get_tree().get_nodes_in_group("aleksandr")[0]
	attack_angle = (aleksandr.global_position - global_position).angle()
	state = states.ATTACK
	attack_animate()

func become_alert():
	behavior = hostility.ALERT

func become_hostile():
	behavior = hostility.HOSTILE

func on_leader_down():
	become_hostile()
