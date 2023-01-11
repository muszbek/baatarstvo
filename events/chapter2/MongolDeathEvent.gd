extends Node2D

signal one_down
signal all_down

var death_counter: int = 0
var leader_down: bool = false

onready var dialogue = get_tree().get_nodes_in_group("dialogue")[-1]
var DIALOGUE = "res://dialogues/chapter_2/execute_ally_end_loop.txt"
signal dialogue(json_resource)

func _ready():
	var _err = connect("dialogue", dialogue, "do_dialogue")

func on_mongol_death():
	death_counter += 1
	$DeathTimer.start()

func _on_DeathTimer_timeout():
	match death_counter:
		1: 
			emit_signal("one_down")
		3: 
			emit_signal("all_down")
			emit_signal("dialogue", DIALOGUE)
