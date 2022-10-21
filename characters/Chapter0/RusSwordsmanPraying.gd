extends "res://characters/MeleeChar.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_0/rus_soldier_praying_loop.txt"

func _ready():
	sprite.animation = "praying_right"
	if facing == directions.LEFT:
		sprite.flip_h = true

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
