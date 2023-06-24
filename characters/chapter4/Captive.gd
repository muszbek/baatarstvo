extends "res://characters/MovingChar.gd"

enum states {IDLE, GO_TO_TARGET, ARRIVED, DEAD, REMOVED}

export var target_name: String
onready var target = get_tree().get_nodes_in_group(target_name)[-1]

func _ready():
	dialogue.connect("script", self, "handle_script")
	idle_animate()

func _physics_process(_delta):
	match state:
		states.GO_TO_TARGET:
			if target.global_position.distance_to(global_position) < 1:
				stop_pathfinding()
				state = states.ARRIVED
				arrive_action()
			move()

func run():
	navigation_target = target.global_position
	start_pathfinding()
	state = states.GO_TO_TARGET

func arrive_action():
	pass
