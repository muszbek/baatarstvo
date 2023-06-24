extends Node2D

const UNARMORED_BEHAVIOR_SCENE = "res://core/PlayerBehaviorUnarmored.tscn"

onready var new_behavior_scene = load(UNARMORED_BEHAVIOR_SCENE)
onready var player = get_tree().get_nodes_in_group("player")[-1]

func _ready():
	switch_player()

func switch_player():
	var old_behavior = player.get_node("PlayerBehavior")
	var new_behavior = new_behavior_scene.instance()
	new_behavior.name = "PlayerBehavior"
	player.call_deferred("remove_child", old_behavior)
	player.call_deferred("add_child", new_behavior)
	var facing = player.directions.BACK
	player.set_deferred("facing", facing)
	player.get_node("PlayerBehavior").call_deferred("idle_animate", facing)
	old_behavior.queue_free()
