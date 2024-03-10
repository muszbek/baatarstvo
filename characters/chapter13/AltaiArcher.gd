extends "res://characters/MovingChar.gd"

enum states {IDLE, MOVING}

export var after_alarm_pos_group: String
export var after_slave_freed_pos_group: String
export var after_slave_freed_target_pos_group: String

onready var after_alarm_pos = get_tree().get_nodes_in_group(after_alarm_pos_group)[-1]
onready var after_slave_freed_pos = get_tree().get_nodes_in_group(after_slave_freed_pos_group)[-1]
onready var after_slave_freed_target_pos = get_tree().get_nodes_in_group(after_slave_freed_target_pos_group)[-1]

func _ready():
	idle_animate()

func on_after_alarm():
	set_deferred("global_position", after_alarm_pos.global_position)

func on_after_slaves_freed():
	set_deferred("global_position", after_slave_freed_pos.global_position)
	navigation_target = after_slave_freed_target_pos.global_position
	start_pathfinding()
	state = states.MOVING
