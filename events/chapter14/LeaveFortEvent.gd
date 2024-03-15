extends "res://events/EventZone.gd"

signal fort_left

func trigger():
	if state == states.ACTIVE: emit_signal("fort_left")
	.trigger()
