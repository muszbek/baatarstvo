extends "res://characters/chapter4/Captive.gd"

const SCRIPT_NAME = "muslim_run"

func _ready():
	character_name = "captive_muslim"
	if state == states.REMOVED: remove()

func handle_script(script_name):
	if script_name == SCRIPT_NAME: run()

func arrive_action():
	state = states.REMOVED
	remove()
	dialogue.emit_signal("next_line")
