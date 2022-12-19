extends Node2D

onready var game = get_tree().get_nodes_in_group("game")[-1]
onready var music = get_tree().get_nodes_in_group("music")[-1]
onready var anim_player = $AnimatedSprite/AnimationPlayer
signal chapter_finish
signal stop_music

func _ready():
	reveal_screen_anim()
	var _err = connect("chapter_finish", game, "on_chapter_finish")
	_err = connect("stop_music", music, "on_stop_music")

func reveal_screen_anim():
	anim_player.play("reveal_screen")

func darken_screen_anim():
	anim_player.play("darken_screen")
	emit_signal("stop_music")

func on_chapter_finish():
	darken_screen_anim()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "darken_screen":
		emit_signal("chapter_finish")
