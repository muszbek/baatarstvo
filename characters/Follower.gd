extends "res://characters/MovingChar.gd"

export var distance_to_keep: int = 24
export var max_distance: int = 96
onready var player = get_tree().get_nodes_in_group("player")[-1]

func follow_with_distance():
	navigation_target = player.global_position
	
	if global_position.distance_to(navigation_target) > distance_to_keep:
		start_pathfinding()
	else:
		stop_pathfinding()

func deblock():
	if global_position.distance_to(navigation_target) > max_distance:
		set_deferred("global_position", navigation_target - Vector2(20, 0))
