extends "res://characters/MeleeEnemy.gd"

enum idle_states {IDLE, MOVING}
const END_POS_DISTANCE = 16

onready var hunters_return_end_pos = get_tree().get_nodes_in_group("hunters_return_end_pos")[-1]
var idle_state

func _ready():
	pass # Replace with function body.

func call_physics_process():
	match state:
		states.IDLE:
			idle_action()
			if is_player_in_sight():
				stop_pathfinding()
				on_sight()
		states.TRACKING:
			tracking_action()
		states.ATTACK:
			pass
		states.DEAD:
			pass

func idle_action():
	match idle_state:
		idle_states.IDLE:
			idle_animate()
		idle_states.MOVING:
			if hunters_return_end_pos.global_position.distance_to(global_position) < END_POS_DISTANCE:
				stop_pathfinding()
				idle_state = idle_states.IDLE
			move()

func go_to_fort():
	set_deferred("behavior", hostility.HOSTILE)
	navigation_target = hunters_return_end_pos.global_position
	start_pathfinding()
	idle_state = idle_states.MOVING
