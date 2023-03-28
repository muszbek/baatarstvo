extends "res://events/MusicEvent.gd"

func trigger():
	.trigger()
	$CollisionShape2D.set_deferred("disabled", true)
