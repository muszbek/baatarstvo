extends "res://core/PlayerBehavior.gd"

func _ready():
	set_deferred("visible", true)

func shield_from_facing(_facing):
	pass

func attack_animate(_facing):
	get_parent().attack_finished()
