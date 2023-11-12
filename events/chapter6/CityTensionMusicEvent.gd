extends "res://events/MusicEvent.gd"

func _ready():
	var atabeg = get_tree().get_nodes_in_group("atabeg")[-1]
	atabeg.connect("atabeg_exited", self, "enable_event")

func enable_event():
	$CollisionShape2D.set_deferred("disabled", false)
