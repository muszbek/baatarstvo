extends Node2D

onready var sound_button = $TouchScreenButton
onready var music = get_tree().get_nodes_in_group("music")[-1]
var on_sprite: Texture = preload("res://assets/buttons/volume_on.png")
var off_sprite: Texture = preload("res://assets/buttons/volume_off.png")

var sound_on: bool = true

func _on_TouchScreenButton_pressed():
	if sound_on:
		sound_on = false
		sound_button.normal = off_sprite
		music.mute(true)
	else:
		sound_on = true
		sound_button.normal = on_sprite
		music.mute(false)
