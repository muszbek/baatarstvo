extends Area2D

signal stop_follow

func _ready():
	for rider in get_tree().get_nodes_in_group("rider_escort"):
		var _err = connect("stop_follow", rider, "on_stop_follow")

func _on_FollowStopEvent_area_entered(_area):
	emit_signal("stop_follow")
