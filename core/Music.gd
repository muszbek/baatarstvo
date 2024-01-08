extends Node

onready var music = $AudioStreamPlayer
onready var fadeout_player = $AnimationPlayer
var playing
var stream_loaded
var default_volume = -10.0

func on_start_music(title: String):
	play_soundtrack(title)

func on_stop_music():
	stop_soundtrack()

func on_set_volume(volume: float):
	default_volume = volume
	music.volume_db = default_volume

func play_soundtrack(path: String):
	if playing == path:
		return
	
	playing = path
	stream_loaded = load(path)
	fadeout_player.play("music_fadeout")

func stop_soundtrack():
	stream_loaded = null
	fadeout_player.play("music_fadeout")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "music_fadeout":
		music.stream = stream_loaded
		music.volume_db = default_volume
		music.play()

func mute(is_mute: bool):
	music.set_stream_paused(is_mute)
