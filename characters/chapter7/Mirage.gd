extends "res://characters/Character.gd"

export var SCRIPT_NAME: String
export var DIALOGUE_SCRIPT: String
var timer: Timer

func _ready():
	dialogue.connect("script", self, "handle_script")

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_SCRIPT
	speak()

func handle_script(script_name):
	if script_name == SCRIPT_NAME: disappear()

func disappear():
	time_end_dialogue_signal()

func time_end_dialogue_signal():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.1
	timer.one_shot = true
	var _err = timer.connect("timeout", self, "dialogue_signal")
	timer.start()

func dialogue_signal():
	dialogue.emit_signal("next_line")
	timer.queue_free()
	remove()
