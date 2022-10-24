extends Node

onready var music = $AudioStreamPlayer
onready var fadeout_player = $AnimationPlayer
var playing
var stream_loaded

func on_start_music(title: String):
	play_soundtrack(title)

func play_soundtrack(path: String):
	if playing == path:
		return
	
	playing = path
	stream_loaded = load(path)
	fadeout_player.play("music_fadeout")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "music_fadeout":
		music.stream = stream_loaded
		music.volume_db = -10.0
		music.play()

func mute(is_mute: bool):
	music.set_stream_paused(is_mute)
