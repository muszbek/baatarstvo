extends "res://events/EventZone.gd"

signal reached_army

func trigger():
	if state == states.ACTIVE: 
		state = states.TRIGGERED
		$CollisionShape2D.set_deferred("disabled", true)
		emit_signal("reached_army")
