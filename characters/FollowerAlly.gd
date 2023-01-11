extends "res://characters/Follower.gd"

### MeleeChar code duplicate
const ATTACK_ANIMATIONS = ["attack_front", "attack_back", "attack_left", "attack_right"]

func attack_animate():
	match facing:
		directions.FRONT:
			animation_player.current_animation = "attack_front"
		directions.BACK:
			animation_player.current_animation = "attack_back"
		directions.LEFT:
			animation_player.current_animation = "attack_left"
		directions.RIGHT:
			animation_player.current_animation = "attack_right"

func death():
	.death()
	get_node("HitboxPivot/MeleeHitbox/HitboxCollision").set_deferred("disabled", true)

func _on_AnimationPlayer_animation_finished(_anim_name):
	pass # Replace with function body.

### Code for fighting enemies
enum hostility {PEACEFUL, ALERT, HOSTILE}

export var behavior = hostility.HOSTILE

onready var los = $LineOfSight
var collision: KinematicCollision2D
var enemies_in_sight = []
var aggroed_enemy = null

func get_enemies_in_sight():
	enemies_in_sight = []
	for enemy in get_tree().get_nodes_in_group("melee_enemy"):
		los.look_at(enemy.global_position)
		var collider = los.get_collider()
		
		if not collider: continue
		if not collider.is_in_group("melee_enemy"): continue
		if collider.state == collider.states.DEAD: continue
		enemies_in_sight.append(collider)

func get_closest_enemy_in_sight():
	var distance_map = {}
	for enemy in enemies_in_sight:
		var distance = global_position.distance_to(enemy.global_position)
		distance_map[distance] = enemy
		
	var min_distance = distance_map.keys().min()
	aggroed_enemy = distance_map[min_distance] if min_distance else null

func aggro():
	if not aggroed_enemy: return
	
	if not pathfinding: start_pathfinding()
	
	navigation_target = aggroed_enemy.global_position
	move()
	attack_on_contact()

func attack_on_contact():
	collision = get_last_slide_collision()
	if not collision: return
	
	if collision.get_collider().is_in_group("melee_enemy"): attack()
	
func attack():
	pass
