extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_12/herd_loop.txt"

func _ready():
	if facing == directions.RIGHT:
		sprite.flip_h = true

func _on_Interactionbox_area_entered(area):
	if area.name != "InteractionboxActive": return
	
	json_resource = DIALOGUE_LOOP
	speak()
