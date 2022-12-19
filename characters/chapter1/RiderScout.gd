extends "res://characters/Follower.gd"

enum states {IDLE, FOLLOWING, DEBLOCKING}

const DIALOGUE_FOLLOW_LOOP = "res://dialogues/chapter_1/rider_loop.txt"

func _physics_process(_delta):
	match state:
		states.IDLE:
			idle_animate()
		states.FOLLOWING:
			follow_with_distance()
			move()
			deblock_self(states.FOLLOWING)
		states.DEBLOCKING:
			move_away_to_distance(states.FOLLOWING)
			move()
			deblock_self(states.FOLLOWING)

func on_start_follow():
	state = states.FOLLOWING

func on_stop_follow():
	state = states.IDLE

func _on_Interactionbox_area_entered(_area):
	match state:
		states.IDLE:
			json_resource = DIALOGUE_FOLLOW_LOOP
			speak()
			state = states.DEBLOCKING
		states.FOLLOWING:
			json_resource = DIALOGUE_FOLLOW_LOOP
			speak()
			state = states.DEBLOCKING
