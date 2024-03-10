extends "res://characters/MeleeEnemy.gd"

onready var hunters_killed_event = get_tree().get_nodes_in_group("hunters_killed_event")[-1]

func _ready():
	hunters_killed_event.connect("open_courtyard", self, "on_open_courtyard")

func on_open_courtyard():
	remove()
