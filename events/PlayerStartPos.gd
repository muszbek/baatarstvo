extends "res://events/EventZone.gd"

func _ready():
	var player = get_tree().get_nodes_in_group("player")[-1]
	
	if not player.state_loaded:
		player.set_deferred("global_position", global_position)
