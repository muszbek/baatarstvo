extends "res://characters/MeleeEnemy.gd"

func idle_animate():
	match behavior:
		hostility.PEACEFUL:
			relaxed_animate()
		hostility.ALERT:
			.idle_animate()
		hostility.HOSTILE:
			.idle_animate()

func relaxed_animate():
	if facing == directions.FRONT:
		sprite.animation = "idle_front"
	if facing == directions.BACK:
		sprite.animation = "idle_back"
	if facing == directions.LEFT:
		sprite.animation = "relaxed_left"
	if facing == directions.RIGHT:
		sprite.animation = "relaxed_right"
