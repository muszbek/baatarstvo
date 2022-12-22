extends KinematicBody2D

signal dialogue(json_resource)

onready var dialogue = get_tree().get_nodes_in_group("dialogue")[-1]
export var DIALOGUE_LOOP: String = ""
var json_resource: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	var _err = connect("dialogue", dialogue, "do_dialogue")

func use():
	emit_signal("dialogue", json_resource)

func _on_Interactionbox_area_entered(_area):
	if DIALOGUE_LOOP:
		json_resource = DIALOGUE_LOOP
		use()
