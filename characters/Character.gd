extends KinematicBody2D

enum directions {FRONT, BACK, LEFT, RIGHT}

export var speed: int = 16
export var facing = directions.FRONT
export var can_be_saved: bool = true
signal dialogue(json_resource)
signal death

onready var sprite = $AnimatedSprite
onready var animation_player = $AnimatedSprite/AnimationPlayer
onready var dialogue = get_tree().get_nodes_in_group("dialogue")[-1]
onready var game = get_tree().get_nodes_in_group("game")[-1]

var state_loaded: bool = false
var json_resource: String = ""
var character_name: String = "NONAME"

var state = 0
var dialogue_state = 0

func _ready():
	var _err = connect("dialogue", dialogue, "do_dialogue")
	dialogue.connect("dialogue_ping", self, "on_receive_dialogue_ping")
	load_on_start()

func _on_Hurtbox_area_entered(_area):
	pass # Replace with function body.

func _on_Interactionbox_area_entered(_area):
	pass # Replace with function body.


func idle_animate():
	if facing == directions.FRONT:
		sprite.animation = "idle_front"
	if facing == directions.BACK:
		sprite.animation = "idle_back"
	if facing == directions.LEFT:
		sprite.animation = "idle_left"
	if facing == directions.RIGHT:
		sprite.animation = "idle_right"

func death():
	$CollisionShape2D.set_deferred("disabled", true)
	get_node("Hurtbox/CollisionShape2D").set_deferred("disabled", true)
	get_node("Interactionbox/CollisionShape2D").set_deferred("disabled", true)
	sprite.play("death")
	emit_signal("death")

func _on_AnimatedSprite_animation_finished():
	if sprite.animation == "death":
		sprite.play("dead")
		
func speak():
	emit_signal("dialogue", json_resource)
	dialogue_ping()
	
func dialogue_ping():
	animation_player.play("dialogue_ping")

func on_receive_dialogue_ping(target: String):
	if target == character_name:
		dialogue_ping()


func save_state():
	return {
		"pos": global_position,
		"facing": facing,
		"state": state,
		"dialogue_state": dialogue_state
	}

func load_state(dict):
	if not dict:
		return
	
	set_deferred("global_position", dict.get("pos"))
	facing = dict.get("facing")
	state = dict.get("state")
	dialogue_state = dict.get("dialogue_state")
	state_loaded = true

func load_on_start():
	var data = game.saved_game.get(get_name())
	load_state(data)
