extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_0/monk_praying_loop.txt"

func _ready():
	sprite.animation = "praying_right"
	if facing == directions.LEFT:
		sprite.flip_h = true

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
