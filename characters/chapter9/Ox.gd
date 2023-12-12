extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_9/ox_loop.txt"

func _ready():
	if facing == directions.RIGHT:
		sprite.flip_h = true

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
