extends Node2D

enum directions {FRONT, BACK, LEFT, RIGHT}
const ATTACK_ANIMATIONS = ["attack_front", "attack_back", "attack_left", "attack_right"]

onready var sprite = $AnimatedSprite
onready var animation_player = $AnimatedSprite/AnimationPlayer
onready var interaction_pivot = $InteractionboxPivot
onready var interaction_player = $InteractionboxPivot/InteractionboxActive/CollisionShape2D/InteractionPlayer

func apply_facing(facing):
	interactionbox_from_facing(facing)
	shield_from_facing(facing)

func interactionbox_from_facing(facing):
	match facing:
		directions.FRONT:
			interaction_pivot.rotation = 0
		directions.BACK:
			interaction_pivot.rotation = PI
		directions.LEFT:
			interaction_pivot.rotation = PI/2
		directions.RIGHT:
			interaction_pivot.rotation = -PI/2

func shield_from_facing(facing):
	var shield_pivot = $ShieldBox
	
	match facing:
		directions.FRONT:
			shield_pivot.rotation = 0
		directions.BACK:
			shield_pivot.rotation = PI
		directions.LEFT:
			shield_pivot.rotation = PI/2
		directions.RIGHT:
			shield_pivot.rotation = -PI/2

func attack_animate(facing):
	match facing:
		directions.FRONT:
			animation_player.current_animation = "attack_front"
		directions.BACK:
			animation_player.current_animation = "attack_back"
		directions.LEFT:
			animation_player.current_animation = "attack_left"
		directions.RIGHT:
			animation_player.current_animation = "attack_right"

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ATTACK_ANIMATIONS:
		get_parent().attack_finished()

func move_animate(facing, movement_vector: Vector2):
	if movement_vector.length() > 0:
		walk_animate(facing)
	else:
		idle_animate(facing)

func walk_animate(facing):
	if facing == directions.FRONT:
		sprite.animation = "walk_front"
	if facing == directions.BACK:
		sprite.animation = "walk_back"
	if facing == directions.LEFT:
		sprite.animation = "walk_left"
	if facing == directions.RIGHT:
		sprite.animation = "walk_right"

func idle_animate(facing):
	if facing == directions.FRONT:
		sprite.animation = "idle_front"
	if facing == directions.BACK:
		sprite.animation = "idle_back"
	if facing == directions.LEFT:
		sprite.animation = "idle_left"
	if facing == directions.RIGHT:
		sprite.animation = "idle_right"

func interact_animate():
	interaction_player.play("interaction")

func death_animate():
	sprite.play("death")

func _on_AnimatedSprite_animation_finished():
	if sprite.animation == "death":
		sprite.play("dead")
