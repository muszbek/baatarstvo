extends "res://core/Player.gd"

const RIDER_BEHAVIOR_SCENE = "res://core/PlayerBehaviorRiderPacific.tscn"

onready var new_behavior_scene = load(RIDER_BEHAVIOR_SCENE)
var animation_player
var character_name = "fort_captain"

func _ready():
	switch_player()
	dialogue.connect("dialogue_ping", self, "on_receive_dialogue_ping")

func switch_player():
	var old_behavior = get_node("PlayerBehavior")
	var new_behavior = new_behavior_scene.instance()
	new_behavior.name = "PlayerBehavior"
	animation_player = new_behavior.get_node("AnimatedSprite").get_node("AnimationPlayer")
	call_deferred("remove_child", old_behavior)
	call_deferred("add_child", new_behavior)
	set_deferred("speed", 36)
	old_behavior.queue_free()

func on_receive_dialogue_ping(target: String):
	if target == character_name:
		dialogue_ping()

func dialogue_ping():
	animation_player.play("dialogue_ping")
