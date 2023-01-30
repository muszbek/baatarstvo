extends "res://characters/FollowerAlly.gd"

enum states {IDLE, FOLLOWING, DEBLOCKING}

const DIALOGUE_START_LOOP = "res://dialogues/chapter_2/rider_ally_start_loop.txt"
const DIALOGUE_FOLLOWING_LOOP = "res://dialogues/chapter_2/rider_ally_following_loop.txt"

onready var exit_camp_handler = get_tree().get_nodes_in_group("exit_camp_event")[-1]
onready var reached_army_handler = get_tree().get_nodes_in_group("reached_army_event")[-1]

func _ready():
	exit_camp_handler.connect("camp_exited", self, "on_camp_exited")
	reached_army_handler.connect("reached_army", self, "on_reached_army")

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

func on_camp_exited(): state = states.FOLLOWING

func on_reached_army(): state = states.IDLE

func _on_Interactionbox_area_entered(area):
	if area.name != "InteractionboxActive": return
	
	match state:
		states.IDLE:
			json_resource = DIALOGUE_START_LOOP
			speak()
		states.FOLLOWING:
			json_resource = DIALOGUE_FOLLOWING_LOOP
			speak()
			state = states.DEBLOCKING
