extends "res://characters/chapter13/AltaiArcher.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_13/altai_loop.txt"

onready var arban = get_tree().get_nodes_in_group("arban")[-1]

func _ready():
	arban.connect("alarm_raised", self, "on_after_alarm")
	arban.connect("slaves_freed", self, "on_after_slaves_freed")

func _physics_process(_delta):
	match state:
		states.IDLE:
			idle_animate()
		states.MOVING:
			if after_slave_freed_target_pos.global_position.distance_to(global_position) < 1:
				facing = directions.RIGHT
				stop_pathfinding()
				state = states.IDLE
			move()

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()
