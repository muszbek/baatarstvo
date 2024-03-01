extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_11/miner_chinese_loop.txt"

func _ready():
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
