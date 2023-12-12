extends "res://characters/Character.gd"

export var DIALOGUE_LOOP: String = ""

func _ready():
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
