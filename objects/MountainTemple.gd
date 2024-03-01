extends KinematicBody2D

onready var sprite = $AnimatedSprite
onready var shaman_eagle = get_tree().get_nodes_in_group("shaman_eagle")[-1]

func _ready():
	shaman_eagle.connect("shamans_attacked", self, "on_shamans_attacked")
	sprite.animation = "default"

func on_shamans_attacked():
	sprite.animation = "burning"
