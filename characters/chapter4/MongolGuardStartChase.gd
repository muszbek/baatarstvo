extends "res://characters/chapter4/MongolNaginata.gd"

enum script_states {IDLE, GO_TO_TARGET, ARRIVED}
const SCRIPT_NAME = "guard_run"
const GUARD_TURN_SCRIPT_NAME = "georgian_run"

onready var run_target = get_tree().get_nodes_in_group("prisoner_georgian_run_pos")[-1]
var script_state = script_states.IDLE

func _ready():
	character_name = "mongol_guard_start_chase"
	dialogue.connect("script", self, "handle_script")

func _physics_process(_delta):
	match script_state:
		script_states.GO_TO_TARGET:
			if run_target.global_position.distance_to(global_position) < 1:
				stop_pathfinding()
				script_state = script_states.ARRIVED
				arrive_action()
			move()

func handle_script(script_name):
	if script_name == GUARD_TURN_SCRIPT_NAME: turn_to_escapee()
	if script_name == SCRIPT_NAME: run()

func turn_to_escapee():
	facing = directions.FRONT

func run():
	navigation_target = run_target.global_position
	start_pathfinding()
	script_state = script_states.GO_TO_TARGET

func arrive_action():
	state = states.REMOVED
	remove()
