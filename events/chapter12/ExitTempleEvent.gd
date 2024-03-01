extends Area2D

onready var player = get_tree().get_nodes_in_group("player")[-1]
onready var entry_pos = get_tree().get_nodes_in_group("exit_temple_pos")[-1]

func _on_EventZone_area_entered(_area):
	teleport_player()

func teleport_player():
	player.set_deferred("global_position", entry_pos.global_position)

func save_state():
	return {"state": null}

func load_state(_dict):
	pass

func load_on_start():
	pass
