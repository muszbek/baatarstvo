extends Node2D

onready var anim_player = $AnimatedSprite/AnimationPlayer

signal screen_finished

func _ready():
	start()

func _process(_delta):
	if Input.is_action_just_pressed("interact"): end()
	if Input.is_action_just_pressed("attack"): end()

func start():
	anim_player.play("reveal_screen")

func end():
	emit_signal("screen_finished")
	queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"reveal_screen": anim_player.play("wait")
		"wait": anim_player.play("darken_screen")
		"darken_screen": end()
