extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_9/mongol_trader_loop.txt"

func _ready():
	character_name = "mongol_trader"

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
