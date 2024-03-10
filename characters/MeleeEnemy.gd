extends "res://characters/MeleeChar.gd"

enum states {IDLE, TRACKING, ABANDON, ATTACK, DEAD, REMOVED}
enum hostility {PEACEFUL, ALERT, HOSTILE}

export var behavior = hostility.HOSTILE
export var enemy_group: String

onready var los = $LineOfSight
onready var player = get_tree().get_nodes_in_group("player")[-1]
var player_angle: float = PI/2
var collision: KinematicCollision2D

func _ready():
	match state:
		states.DEAD: dead_animate()
		states.REMOVED: remove()

func _physics_process(_delta):
	call_physics_process()

func call_physics_process():
	match state:
		states.IDLE:
			idle_animate()
			if is_player_in_sight(): on_sight()
		states.TRACKING:
			tracking_action()
		states.ABANDON:
			return_to_pos()
		states.ATTACK:
			pass
		states.DEAD:
			pass

func _on_Hurtbox_area_entered(area):
	if area.name == "Hurtbox": return
	
	state = states.DEAD
	stop_pathfinding()
	death()

func is_player_in_sight() -> bool:
	los.look_at(player.global_position)
	var collider = los.get_collider()
	return collider and collider.is_in_group("player")

func on_sight():
	if not enemy_group: 
		on_sight_action()
	else: 
		get_tree().call_group("melee_enemy", "group_on_sight", enemy_group)

func group_on_sight(group_alert):
	if group_alert == enemy_group: on_sight_action()

func on_sight_action():
	if state == states.IDLE:
		state = states.TRACKING

func tracking_action():
	match behavior:
		hostility.PEACEFUL:
			state = states.IDLE
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
	
	if not pathfinding: start_pathfinding()
	
	navigation_target = player.global_position
	move()
	attack_on_contact()
	abandon_on_contact()

func attack_on_contact():
	collision = get_last_slide_collision()
	if not collision: return
	
	if collision.get_collider().is_in_group("player"): attack()

# An enemy will abandon if he meets his buddy who is abandoning.
# Reason: in tight places tracking and abandoning enemies can get stuck.
func abandon_on_contact():
	collision = get_last_slide_collision()
	if not collision: return
	
	var collider = collision.get_collider()
	
	if collider.is_in_group("melee_enemy"):
		if collider.state == states.ABANDON:
			state = states.ABANDON

func attack():
	state = states.ATTACK
	attack_animate()

func return_to_pos():
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ATTACK_ANIMATIONS:
		if state == states.ATTACK:
			state = states.TRACKING
