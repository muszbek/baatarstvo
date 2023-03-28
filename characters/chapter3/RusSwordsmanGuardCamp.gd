extends "res://characters/MeleeChar.gd"

enum states {CLOSED, OPENING, OPEN}
const DIALOGUE_LOOP_CLOSED = "res://dialogues/chapter_3/rus_guard_camp_loop_1.txt"
const DIALOGUE_LOOP_OPEN = "res://dialogues/chapter_3/rus_guard_camp_loop_2.txt"

export var open_gate_target_name: String
onready var open_gate_target = get_tree().get_nodes_in_group(open_gate_target_name)[-1]
onready var father = get_tree().get_nodes_in_group("father")[-1]

func _ready():
	father.connect("father_let_go", self, "open_gate")
	idle_animate()
	state = states.CLOSED
	
func _physics_process(_delta):
	match state:
		states.OPENING:
			if open_gate_target.global_position.distance_to(global_position) < 1:
				facing = directions.BACK
				stop_pathfinding()
				state = states.OPEN
			move()

func _on_Interactionbox_area_entered(_area):
	match state:
		states.CLOSED:
			json_resource = DIALOGUE_LOOP_CLOSED
			speak()
		states.OPEN:
			json_resource = DIALOGUE_LOOP_OPEN
			speak()

func open_gate():
	navigation_target = open_gate_target.global_position
	start_pathfinding()
	state = states.OPENING
