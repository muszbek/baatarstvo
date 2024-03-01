extends "res://characters/Character.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_12/horse_loop.txt"

onready var player = get_tree().get_nodes_in_group("player")[-1]
onready var interaction_box = player.get_node("Eventbox")

func _ready():
	if facing == directions.RIGHT:
		sprite.flip_h = true

func _on_Interactionbox_area_entered(area):
	if area == interaction_box:
		json_resource = DIALOGUE_LOOP
		speak()
