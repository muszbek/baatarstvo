extends "res://characters/chapter2/MongolNaginata.gd"

onready var death_event_handler = get_tree().get_nodes_in_group("mongol_death_event")[-1]

# Called when the node enters the scene tree for the first time.
func _ready():
	var _err = connect("death", death_event_handler, "on_mongol_death")
	death_event_handler.connect("one_down", self, "be_alert")

func be_alert():
	behavior = hostility.ALERT
