extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_13/horse_loop.txt"

onready var arban = get_tree().get_nodes_in_group("arban")[-1]

func _ready():
	arban.connect("alarm_raised", self, "on_after_alarm")
	if facing == directions.RIGHT:
		sprite.flip_h = true

func _on_Interactionbox_area_entered(area):
	if area.name != "InteractionboxActive": return
	
	json_resource = DIALOGUE_LOOP
	speak()

func on_after_alarm():
	remove()
