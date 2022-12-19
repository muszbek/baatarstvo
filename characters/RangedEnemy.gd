extends "res://characters/RangedChar.gd"

enum states {IDLE, ATTACK, DEAD}
enum hostility {PEACEFUL, ALERT, HOSTILE}

export var behavior = hostility.HOSTILE

onready var los = $LineOfSight
onready var player = get_tree().get_nodes_in_group("player")[-1]
var player_angle: float = PI/2
var attack_angle: float

func _physics_process(_delta):
	match state:
		states.IDLE:
			idle_animate()
			if is_player_in_sight():
				player_spotted_action()
		states.ATTACK:
			pass
		states.DEAD:
			pass

func _on_Hurtbox_area_entered(area):
	if area.name == "Hurtbox": return
	
	state = states.DEAD
	death()

func is_player_in_sight() -> bool:
	var player_pos = player.global_position
	los.look_at(player_pos)
	player_angle = (player_pos - global_position).angle()
	var collider = los.get_collider()
	return collider and collider.is_in_group("player")

func player_spotted_action():
	match behavior:
		hostility.PEACEFUL:
			pass
		hostility.ALERT:
			look_at_player()
		hostility.HOSTILE:
			attack()

func look_at_player():
	adjust_facing(player_angle)

func attack():
	if player.state == player.states.DEAD:
		return
	
	state = states.ATTACK
	attack_angle = player_angle
	adjust_facing(attack_angle)
	attack_animate()

func shoot_at_angle():
	shoot(attack_angle)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ATTACK_ANIMATIONS:
		if state == states.ATTACK:
			state = states.IDLE
