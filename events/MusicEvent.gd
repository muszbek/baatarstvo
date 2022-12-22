extends Area2D

signal start_music(title_to_start)

onready var music = get_tree().get_nodes_in_group("music")[-1]
export var TITLE: String

func _ready():
	var _err = connect("start_music", music, "on_start_music")

func trigger():
	emit_signal("start_music", TITLE)

func _on_MusicEvent_area_entered(_area):
	if TITLE:
		trigger()
