extends "res://events/EventZone.gd"

signal set_volume(volume)

onready var music = get_tree().get_nodes_in_group("music")[-1]
export var VOLUME: float

func _ready():
	var _err = connect("set_volume", music, "on_set_volume")

func trigger():
	if state == states.ACTIVE:
		state = states.TRIGGERED
		$CollisionShape2D.set_deferred("disabled", true)
		emit_signal("set_volume", VOLUME)

func _on_EventZone_area_entered(_area):
	trigger()
