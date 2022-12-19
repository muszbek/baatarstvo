extends Area2D

signal start_follow

func _ready():
	for rider in get_tree().get_nodes_in_group("rider_escort"):
		var _err = connect("start_follow", rider, "on_start_follow")

func _on_FollowStartEvent_area_entered(_area):
	emit_signal("start_follow")
