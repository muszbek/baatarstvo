extends "res://characters/chapter6/PersianGuard.gd"

enum gate_states {CLOSED, MOVING, OPEN}
const DIALOGUE_LOOP_CLOSED = "res://dialogues/chapter_6/persian_gate_guard_loop_1.txt"
const DIALOGUE_LOOP_OPEN = "res://dialogues/chapter_6/persian_gate_guard_loop_2.txt"

export var open_gate_target_name: String
export var fight_pos_target_name: String
onready var open_gate_target = get_tree().get_nodes_in_group(open_gate_target_name)[-1]
onready var fight_pos_target = get_tree().get_nodes_in_group(fight_pos_target_name)[-1]
var gate_state

func _ready():
	var constable = get_tree().get_nodes_in_group("constable")[-1]
	var atabeg = get_tree().get_nodes_in_group("atabeg")[-1]
	constable.connect("allowed_in_castle", self, "open_gate")
	atabeg.connect("atabeg_exited", self, "to_interior_post")
	idle_animate()
	gate_state = gate_states.CLOSED
	
func _physics_process(_delta):
	match gate_state:
		gate_states.MOVING:
			if open_gate_target.global_position.distance_to(global_position) < 1:
				facing = directions.LEFT
				stop_pathfinding()
				gate_state = gate_states.OPEN
			move()

func _on_Interactionbox_area_entered(_area):
	match gate_state:
		gate_states.CLOSED:
			json_resource = DIALOGUE_LOOP_CLOSED
			speak()
		gate_states.OPEN:
			json_resource = DIALOGUE_LOOP_OPEN
			speak()

func open_gate():
	navigation_target = open_gate_target.global_position
	start_pathfinding()
	gate_state = gate_states.MOVING

func to_interior_post():
	set_deferred("global_position", fight_pos_target.global_position)
	facing = directions.RIGHT
	idle_animate()
