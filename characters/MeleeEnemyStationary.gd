extends "res://characters/MeleeEnemy.gd"

const start_pos_tolerance: int = 8
export var chase_distance: int = 80
var start_pos

func _ready():
	start_pos = global_position

func track():
	.track()
	
	if global_position.distance_to(start_pos) > chase_distance:
		state = states.ABANDON

func return_to_pos():
	if not pathfinding: start_pathfinding()
	
	navigation_target = start_pos
	move()
	did_return_to_origin()

func did_return_to_origin():
	if global_position.distance_to(start_pos) < start_pos_tolerance:
		state = states.IDLE

func restart_chase():
	if state == states.ABANDON:
		state = states.TRACKING
