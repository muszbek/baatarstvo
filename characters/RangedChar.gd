extends "res://characters/MovingChar.gd"

const ATTACK_ANIMATIONS = ["attack_front", "attack_back", "attack_left", "attack_right"]

onready var arrow_field = get_tree().get_nodes_in_group("game")[-1]
var arrow = preload("res://misc/Arrow.tscn")

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

func shoot_direct():
	match facing:
		directions.FRONT:
			shoot(PI/2)
		directions.BACK:
			shoot(-PI/2)
		directions.LEFT:
			shoot(PI)
		directions.RIGHT:
			shoot(0)

func shoot(angle: float):
	# facing right is zero rotation
	var arrow_instance = arrow.instance()
	arrow_instance.position = get_global_position()
	arrow_instance.rotation = angle
	arrow_field.add_child(arrow_instance)
