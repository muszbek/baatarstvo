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

func deblock_self(next_state):
	if global_position.distance_to(navigation_target) > max_distance:
		set_deferred("global_position", navigation_target - Vector2(distance_to_keep, 0))
		state = next_state

func move_away_to_distance(next_state):
	if global_position.distance_to(player.global_position) < distance_to_keep:
		move_away_from_player()
	else:
		velocity = Vector2.ZERO
		state = next_state

func move_away_from_player():
	var move_vector = global_position - player.global_position
	velocity = move_vector.normalized() * speed
