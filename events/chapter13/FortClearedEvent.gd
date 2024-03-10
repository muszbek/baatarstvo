extends "res://events/EventZone.gd"

const total_guards = 24

var total_killed
onready var fort_guards = get_tree().get_nodes_in_group("fort_guard")
onready var player = get_tree().get_nodes_in_group("player")[-1]
signal fort_hostile

func _ready():
	total_killed = 0
	
	for guard in fort_guards:
		guard.connect("death", self, "on_guard_killed")
		var _err = connect("fort_hostile", guard, "become_hostile")

func on_guard_killed():
	if player.state == player.states.DEAD:
		return
	
	total_killed += 1
	
	if total_killed == 1:
		emit_signal("fort_hostile")
	
	if total_killed == total_guards:
		json_resource = DIALOGUE
		trigger()

## This event should never be saved, the guards are respawning as well
func save_state():
	return {"state": states.ACTIVE}
