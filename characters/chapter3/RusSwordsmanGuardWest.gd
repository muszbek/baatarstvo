extends "res://characters/MeleeChar.gd"

enum states {CLOSED, OPENING, OPEN, CLOSING, RE_CLOSED}
const DIALOGUE_CLOSED = "res://dialogues/chapter_3/rus_guard_west_1.txt"
const DIALOGUE_LOOP_OPEN = "res://dialogues/chapter_3/rus_guard_west_loop_1.txt"
const DIALOGUE_LOOP_RECLOSED = "res://dialogues/chapter_3/rus_guard_west_loop_2.txt"

export var open_gate_target_name: String
export var close_gate_target_name: String
onready var open_gate_target = get_tree().get_nodes_in_group(open_gate_target_name)[-1]
onready var close_gate_target = get_tree().get_nodes_in_group(close_gate_target_name)[-1]
onready var petrov = get_tree().get_nodes_in_group("petrov")[-1]

func _ready():
	idle_animate()
	petrov.connect("petrov_talked", self, "close_gate")
	state = states.CLOSED
	
func _physics_process(_delta):
	match state:
		states.OPENING:
			if open_gate_target.global_position.distance_to(global_position) < 1:
				facing = directions.LEFT
				stop_pathfinding()
				state = states.OPEN
			move()
		states.CLOSING:
			if close_gate_target.global_position.distance_to(global_position) < 1:
				facing = directions.LEFT
				stop_pathfinding()
				state = states.RE_CLOSED
			move()

func _on_Interactionbox_area_entered(_area):
	match state:
		states.CLOSED:
			json_resource = DIALOGUE_CLOSED
			speak()
			open_gate()
		states.OPEN:
			json_resource = DIALOGUE_LOOP_OPEN
			speak()
		states.RE_CLOSED:
			json_resource = DIALOGUE_LOOP_RECLOSED
			speak()

func open_gate():
	navigation_target = open_gate_target.global_position
	start_pathfinding()
	state = states.OPENING

func close_gate():
	navigation_target = close_gate_target.global_position
	start_pathfinding()
	state = states.CLOSING
