extends Node2D

const SCRIPT_NAME = "hunters_return"

onready var dialogue = get_tree().get_nodes_in_group("dialogue")[-1]
onready var hunters_return_start_pos = get_tree().get_nodes_in_group("hunters_return_start_pos")[-1]
onready var hunters = get_tree().get_nodes_in_group("fort_hunter")
signal hunters_go_fort

func _ready():
	dialogue.connect("script", self, "handle_script")
	
	for hunter in hunters:
		var _err = connect("hunters_go_fort", hunter, "go_to_fort")

func handle_script(script_name):
	match script_name:
		SCRIPT_NAME:
			move_group()
			$DialogueStepTimer.start()

func _on_DialogueStepTimer_timeout():
	dialogue.emit_signal("next_line")

func move_group():
	set_deferred("global_position", hunters_return_start_pos.global_position)
	emit_signal("hunters_go_fort")
