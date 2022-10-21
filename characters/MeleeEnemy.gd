extends "res://characters/MeleeChar.gd"

enum states {IDLE, TRACKING, ATTACK, DEAD}
enum hostility {PEACEFUL, ALERT, HOSTILE}

export var behavior = hostility.HOSTILE

onready var los = $LineOfSight
onready var player = get_tree().get_nodes_in_group("player")[-1]
var player_angle: float = PI/2
var collision: KinematicCollision2D

func _physics_process(_delta):
	match state:
		states.IDLE:
			idle_animate()
			if is_player_in_sight(): state = states.TRACKING
		states.TRACKING:
			tracking_action()
		states.ATTACK:
			pass
		states.DEAD:
			pass

func _on_Hurtbox_area_entered(_area):
	state = states.DEAD
	stop_pathfinding()
	death()

func is_player_in_sight() -> bool:
	los.look_at(player.global_position)
	var collider = los.get_collider()
	return collider and collider.is_in_group("player")

func tracking_action():
	match behavior:
		hostility.PEACEFUL:
			pass
		hostility.ALERT:
			look_at_player()
		hostility.HOSTILE:
			track()

func look_at_player():
	player_angle = (player.global_position - global_position).angle()
	adjust_facing(player_angle)
	idle_animate()

func track():
	if player.state == player.states.DEAD:
		idle_animate()
		return
	
	if not pathfinding:
		start_pathfinding()
	
	navigation_target = player.global_position
	move()
	attack_on_contact()

func attack_on_contact():
	collision = get_last_slide_collision()
	if not collision:
		return
	
	if collision.get_collider().is_in_group("player"):
		attack()

func attack():
	state = states.ATTACK
	attack_animate()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ATTACK_ANIMATIONS:
		if state == states.ATTACK:
			state = states.TRACKING
