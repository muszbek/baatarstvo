extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_13/horse_loop.txt"

onready var hunters_killed_event = get_tree().get_nodes_in_group("hunters_killed_event")[-1]

func _ready():
	hunters_killed_event.connect("open_courtyard", self, "on_open_courtyard")
	if facing == directions.RIGHT:
		sprite.flip_h = true

func _on_Interactionbox_area_entered(area):
	if area.name != "InteractionboxActive": return
	
	json_resource = DIALOGUE_LOOP
	speak()

func on_open_courtyard():
	remove()
