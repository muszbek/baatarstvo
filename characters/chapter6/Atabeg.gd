extends "res://characters/MovingChar.gd"

enum script_states {ENTER, SCRIPT_MOVE, SCRIPT_STOP}
const SCRIPT_NAME = "atabeg_exit"

onready var script_move_target = get_tree().get_nodes_in_group("atabeg_exit_pos")[-1]
var script_state
signal atabeg_exited

func _ready():
	character_name = "atabeg"
	dialogue.connect("script", self, "handle_script")
	script_state = script_states.ENTER

func _physics_process(_delta):
	match script_state:
		script_states.SCRIPT_MOVE:
			if script_move_target.global_position.distance_to(global_position) < 1:
				stop_pathfinding()
				script_state = script_states.SCRIPT_STOP
				arrive_action()
			move()

func handle_script(script_name):
	if script_name == SCRIPT_NAME: atabeg_exit()

func atabeg_exit():
	navigation_target = script_move_target.global_position
	start_pathfinding()
	script_state = script_states.SCRIPT_MOVE

func arrive_action():
	dialogue.emit_signal("next_line")
	emit_signal("atabeg_exited")
	remove()
