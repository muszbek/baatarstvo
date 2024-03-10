extends "res://events/EventZone.gd"

const total_hunters = 4

var total_killed
onready var hunters = get_tree().get_nodes_in_group("fort_hunter")
onready var player = get_tree().get_nodes_in_group("player")[-1]
signal open_courtyard

func _ready():
	total_killed = 0
	
	for hunter in hunters:
		hunter.connect("death", self, "on_hunter_killed")

func on_hunter_killed():
	if player.state == player.states.DEAD:
		return
	
	total_killed += 1
	
	if total_killed == total_hunters:
		emit_signal("open_courtyard")
		json_resource = DIALOGUE
		trigger()

## This event should never be saved, the hunters are respawning as well
func save_state():
	return {"state": states.ACTIVE}
