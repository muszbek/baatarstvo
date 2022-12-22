extends "res://characters/MovingChar.gd"

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
