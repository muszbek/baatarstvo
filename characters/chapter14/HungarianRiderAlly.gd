extends "res://characters/FollowerAlly.gd"

enum states {IDLE, FOLLOWING, DEBLOCKING}

const DIALOGUE_LOOP = "res://dialogues/chapter_14/rider_loop.txt"

onready var leave_fort_handler = get_tree().get_nodes_in_group("leave_fort_event")[-1]

func _ready():
	character_name = "hungarian_rider"
	leave_fort_handler.connect("fort_left", self, "on_fort_left")

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

func on_fort_left(): state = states.FOLLOWING

func _on_Interactionbox_area_entered(area):
	if area.name != "InteractionboxActive": return
	
	match state:
		states.IDLE:
			json_resource = DIALOGUE_LOOP
			speak()
		states.FOLLOWING:
			json_resource = DIALOGUE_LOOP
			speak()
			state = states.DEBLOCKING
