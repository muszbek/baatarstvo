extends "res://characters/Follower.gd"

enum states {START, BISHOP_SPOKEN, FOLLOWING, DEBLOCKING, SCRIPT_MOVE, SCRIPT_STOP, DEAD}

const DIALOGUE_FIND_BISHOP = "res://dialogues/chapter_0/aleksandr_1.txt"
const DIALOGUE_HEAD_OUT_BRIEF = "res://dialogues/chapter_0/aleksandr_2.txt"
const DIALOGUE_FOLLOW_LOOP = "res://dialogues/chapter_0/aleksandr_loop.txt"
const SCRIPT_NAME = "kipchak_spotted"
const SCRIPT_MOVE_TARGET_TOLERANCE = 10
signal ready_to_leave

onready var script_move_target = get_tree().get_nodes_in_group("kipchak_spotted_pos")[-1]

func _ready():
	character_name = "aleksandr"
	dialogue.connect("script", self, "handle_script")

func _physics_process(_delta):
	match state:
		states.START:
			idle_animate()
		states.FOLLOWING:
			follow_with_distance()
			move()
			deblock_self(states.FOLLOWING)
		states.DEBLOCKING:
			move_away_to_distance(states.FOLLOWING)
			move()
			deblock_self(states.FOLLOWING)
		states.SCRIPT_MOVE:
			move()
			check_script_movement_end()
		states.SCRIPT_STOP:
			move()

func _on_Interactionbox_area_entered(_area):
	match state:
		states.START:
			json_resource = DIALOGUE_FIND_BISHOP
			speak()
		states.BISHOP_SPOKEN:
			json_resource = DIALOGUE_HEAD_OUT_BRIEF
			speak()
			state = states.FOLLOWING
			emit_signal("ready_to_leave")
		states.FOLLOWING:
			json_resource = DIALOGUE_FOLLOW_LOOP
			speak()
			state = states.DEBLOCKING

func _on_Hurtbox_area_entered(_area):
	state = states.DEAD
	death()
	dialogue.emit_signal("next_line")

func bishop_spoken():
	state = states.BISHOP_SPOKEN

func handle_script(script_name):
	if script_name == SCRIPT_NAME: kipchak_spotted_scipt()

func kipchak_spotted_scipt():
	stop_pathfinding()
	
	$CollisionShape2D.set_deferred("disabled", true)
	
	navigation_target = script_move_target.global_position
	start_pathfinding()
	state = states.SCRIPT_MOVE

func check_script_movement_end():
	var distance_to_target = script_move_target.global_position.distance_to(global_position)
	
	if  distance_to_target < SCRIPT_MOVE_TARGET_TOLERANCE:
		facing = directions.RIGHT
		stop_pathfinding()
		state = states.SCRIPT_STOP
		dialogue.emit_signal("next_line")
