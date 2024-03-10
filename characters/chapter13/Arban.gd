extends "res://characters/chapter13/AltaiArcher.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_13/arban_loop.txt"

const SCRIPT_NAME_1 = "alarm_raised"
const SCRIPT_NAME_2 = "arban_arrive"

signal alarm_raised
signal slaves_freed

func _ready():
	character_name = "arban"
	dialogue.connect("script", self, "handle_script")

func _physics_process(_delta):
	match state:
		states.IDLE:
			idle_animate()
		states.MOVING:
			if after_slave_freed_target_pos.global_position.distance_to(global_position) < 1:
				facing = directions.RIGHT
				stop_pathfinding()
				state = states.IDLE
				dialogue.emit_signal("next_line")
			move()

func handle_script(script_name):
	match script_name:
		SCRIPT_NAME_1: 
			emit_signal("alarm_raised")
			$DialogueStepTimer.start()
			on_after_alarm()
		SCRIPT_NAME_2:
			emit_signal("slaves_freed")
			on_after_slaves_freed()

func _on_Interactionbox_area_entered(_area):
	json_resource = DIALOGUE_LOOP
	speak()

func _on_DialogueStepTimer_timeout():
	dialogue.emit_signal("next_line")
