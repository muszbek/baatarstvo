extends "res://events/EventZone.gd"

signal negotiation_zone_entered

func trigger():
	if state == states.ACTIVE:
		state = states.TRIGGERED
		$CollisionShape2D.set_deferred("disabled", true)
		emit_signal("negotiation_zone_entered")

func _on_EventZone_area_entered(_area):
	trigger()
