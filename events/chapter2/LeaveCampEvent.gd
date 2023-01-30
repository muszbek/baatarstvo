extends "res://events/EventZone.gd"

signal camp_exited

func trigger():
	if state == states.ACTIVE: emit_signal("camp_exited")
	.trigger()
