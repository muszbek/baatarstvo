extends "res://characters/chapter6/Camel.gd"

const BLOCK_POS_TARGET_NAME = "block_pos"

onready var block_pos_target = get_tree().get_nodes_in_group(BLOCK_POS_TARGET_NAME)[-1]

func _ready():
	var atabeg = get_tree().get_nodes_in_group("atabeg")[-1]
	atabeg.connect("atabeg_exited", self, "block_bridge")

func block_bridge():
	set_deferred("global_position", block_pos_target.global_position)
