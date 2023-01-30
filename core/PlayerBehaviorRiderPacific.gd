extends "res://core/PlayerBehavior.gd"

func shield_from_facing(_facing):
	pass

func attack_animate(_facing):
	get_parent().attack_finished()
