extends "res://characters/chapter4/Captive.gd"

const SCRIPT_NAME = "coward_warn"

signal kill_prisoner_coward
signal prisoner_death

func _ready():
	character_name = "captive_coward"
	if state == states.DEAD: dead_animate()

func handle_script(script_name):
	if script_name == SCRIPT_NAME: run()

func arrive_action():
	state = states.ARRIVED
	facing = directions.LEFT
	idle_animate()
	emit_signal("kill_prisoner_coward")

func _on_Hurtbox_area_entered(_area):
	state = states.DEAD
	death()
	emit_signal("prisoner_death")
