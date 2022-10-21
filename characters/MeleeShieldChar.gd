extends "res://characters/MeleeChar.gd"

onready var shield_pivot = $ShieldBox

func shield_from_facing():
	match facing:
		directions.FRONT:
			shield_pivot.rotation = 0
		directions.BACK:
			shield_pivot.rotation = PI
		directions.LEFT:
			shield_pivot.rotation = PI/2
		directions.RIGHT:
			shield_pivot.rotation = -PI/2
