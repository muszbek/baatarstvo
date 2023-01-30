extends "res://characters/chapter2/HorseReined.gd"

const RIDER_BEHAVIOR_SCENE = "res://core/PlayerBehaviorRiderPacific.tscn"

onready var new_behavior_scene = load(RIDER_BEHAVIOR_SCENE)
onready var player = get_tree().get_nodes_in_group("player")[-1]
onready var parent = player.get_parent()
signal mount_event

func _on_Interactionbox_area_entered(_area):
	switch_player()
	queue_free()

func switch_player():
	var old_behavior = player.get_node("PlayerBehavior")
	var new_behavior = new_behavior_scene.instance()
	new_behavior.name = "PlayerBehavior"
	player.call_deferred("remove_child", old_behavior)
	player.call_deferred("add_child", new_behavior)
	player.set_deferred("speed", 36)
	emit_signal("mount_event")
	old_behavior.queue_free()
