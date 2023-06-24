extends KinematicBody2D

enum states {ACTIVE, TRIGGERED}
const SWORDSMAN_BEHAVIOR_SCENE = "res://core/PlayerBehavior.tscn"

onready var new_behavior_scene = load(SWORDSMAN_BEHAVIOR_SCENE)
onready var player = get_tree().get_nodes_in_group("player")[-1]
onready var petrov = get_tree().get_nodes_in_group("petrov")[-1]
onready var parent = player.get_parent()
var state = states.ACTIVE

signal weapon_equipped

func _ready():
	var _err = connect("weapon_equipped", petrov, "on_weapon_equipped")
	
func _on_Interactionbox_area_entered(_area):
	if state == states.ACTIVE:
		state = states.TRIGGERED
		use()

func use():
	var old_behavior = player.get_node("PlayerBehavior")
	var new_behavior = new_behavior_scene.instance()
	new_behavior.name = "PlayerBehavior"
	player.call_deferred("remove_child", old_behavior)
	player.call_deferred("add_child", new_behavior)
	emit_signal("weapon_equipped")
	old_behavior.queue_free()
