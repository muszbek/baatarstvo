extends Node2D

onready var anim_player = $AnimationPlayer
onready var chapter_selector = $Camera2D/ChapterSelectCanvas/ChapterSelector

signal start_screen_finished(chapter)

func _ready():
	start()

func _process(_delta):
	if Input.is_action_just_pressed("interact"): animate_end()
	if Input.is_action_just_pressed("attack"): animate_end()

func start():
	anim_player.play("camera_move")

func animate_end():
	anim_player.play("darken_screen")

func end():
	var chapter: int = chapter_selector.current_chapter
	emit_signal("start_screen_finished", chapter)
	queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"darken_screen": end()
