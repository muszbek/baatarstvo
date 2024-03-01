extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_11/miner_soldier_loop.txt"

func _ready():
	character_name = "miner_soldier"
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
