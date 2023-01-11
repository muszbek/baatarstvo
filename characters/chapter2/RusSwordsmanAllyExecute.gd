extends "res://characters/FollowerAlly.gd"

enum states {IDLE, FOLLOWING, DEBLOCKING, AGGRESSIVE, ATTACK, FINISHED}

const DIALOGUE_START_LOOP = "res://dialogues/chapter_2/execute_ally_start_loop.txt"
const DIALOGUE_END_LOOP = "res://dialogues/chapter_2/execute_ally_end_loop.txt"

onready var enter_zone_handler = get_tree().get_nodes_in_group("negotiation_zone_event")[-1]
onready var death_event_handler = get_tree().get_nodes_in_group("mongol_death_event")[-1]

func _ready():
	enter_zone_handler.connect("negotiation_zone_entered", self, "zone_entered")
	death_event_handler.connect("one_down", self, "on_one_down")
	death_event_handler.connect("all_down", self, "on_all_down")

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
		states.AGGRESSIVE:
			get_enemies_in_sight()
			if not enemies_in_sight:
				follow_with_distance()
				move()
				deblock_self(states.AGGRESSIVE)
			else:
				get_closest_enemy_in_sight()
				aggro()
		states.ATTACK:
			pass
		states.FINISHED:
			idle_animate()

func attack():
	state = states.ATTACK
	attack_animate()

func zone_entered(): state = states.FOLLOWING

func on_one_down(): state = states.AGGRESSIVE

func on_all_down(): state = states.FINISHED

func _on_Interactionbox_area_entered(area):
	if area.name != "InteractionboxActive": return
	
	match state:
		states.IDLE:
			json_resource = DIALOGUE_START_LOOP
			speak()
		states.FOLLOWING:
			json_resource = DIALOGUE_START_LOOP
			speak()
			state = states.DEBLOCKING
		states.FINISHED:
			json_resource = DIALOGUE_END_LOOP
			speak()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ATTACK_ANIMATIONS:
		if state == states.ATTACK:
			state = states.AGGRESSIVE
