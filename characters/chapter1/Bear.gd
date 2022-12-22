extends "res://characters/MeleeEnemyStationary.gd"

var health: int = 4

func _ready():
	character_name = "bear"

func _on_Hurtbox_area_entered(_area):
	health -= 1
	restart_chase()
	if health == 0: die()

func die():
	state = states.DEAD
	stop_pathfinding()
	death()
