extends Area2D

enum states {ACTIVE, TRIGGERED}

signal dialogue(json_resource)

onready var dialogue = get_tree().get_nodes_in_group("dialogue")[-1]
onready var game = get_tree().get_nodes_in_group("game")[-1]
export var DIALOGUE = ""
var json_resource: String = ""
var state = states.ACTIVE

# Called when the node enters the scene tree for the first time.
func _ready():
	var _err = connect("dialogue", dialogue, "do_dialogue")
	load_on_start()

func trigger():
	if state == states.ACTIVE:
		state = states.TRIGGERED
		$CollisionShape2D.set_deferred("disabled", true)
		emit_signal("dialogue", json_resource)

func _on_EventZone_area_entered(_area):
	if DIALOGUE:
		json_resource = DIALOGUE
		trigger()


func save_state():
	return {"state": state}

func load_state(dict):
	if not dict:
		return
	
	state = dict.get("state")

func load_on_start():
	var data = game.saved_game.get(get_name())
	load_state(data)
