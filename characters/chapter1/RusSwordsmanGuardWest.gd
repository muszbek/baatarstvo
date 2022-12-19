extends "res://characters/MeleeChar.gd"

enum states {CLOSED, MOVING, OPEN}
const DIALOGUE_LOOP_CLOSED = "res://dialogues/chapter_1/rus_guard_west_loop_1.txt"
const DIALOGUE_LOOP_OPEN = "res://dialogues/chapter_1/rus_guard_west_loop_2.txt"

export var open_gate_target_name: String
onready var open_gate_target = get_tree().get_nodes_in_group(open_gate_target_name)[-1]

func _ready():
	idle_animate()
	state = states.CLOSED
	
func _physics_process(_delta):
	match state:
		states.MOVING:
			if open_gate_target.global_position.distance_to(global_position) < 1:
				facing = directions.FRONT
				stop_pathfinding()
				state = states.OPEN
			move()

func _on_Interactionbox_area_entered(_area):
	match state:
		states.CLOSED:
			json_resource = DIALOGUE_LOOP_CLOSED
			speak()
			open_gate_command()
		states.OPEN:
			json_resource = DIALOGUE_LOOP_OPEN
			speak()

func open_gate_command():
	get_tree().call_group("guard_west", "open_gate")

func open_gate():
	navigation_target = open_gate_target.global_position
	start_pathfinding()
	state = states.MOVING
