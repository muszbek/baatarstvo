extends "res://characters/MeleeChar.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_2/rus_soldier_loop.txt"

func _ready():
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
