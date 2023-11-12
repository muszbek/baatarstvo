extends "res://events/EventZone.gd"

onready var civilian = get_tree().get_nodes_in_group("civilian_sitting")[-1]

func _ready():
	civilian.connect("sitting_civilian_talked", self, "disable_event")

func disable_event():
	$CollisionShape2D.set_deferred("disabled", true)
