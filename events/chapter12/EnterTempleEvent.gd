extends Area2D

onready var player = get_tree().get_nodes_in_group("player")[-1]
onready var entry_pos = get_tree().get_nodes_in_group("enter_temple_pos")[-1]
onready var shaman_eagle = get_tree().get_nodes_in_group("shaman_eagle")[-1]

func _ready():
	shaman_eagle.connect("shamans_attacked", self, "on_shamans_attacked")

func _on_EventZone_area_entered(_area):
	teleport_player()

func teleport_player():
	player.set_deferred("global_position", entry_pos.global_position)

func on_shamans_attacked():
	$CollisionShape2D.set_deferred("disabled", true)

func save_state():
	return {"state": null}

func load_state(_dict):
	pass

func load_on_start():
	pass
