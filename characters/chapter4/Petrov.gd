extends "res://characters/Character.gd"

enum states {IDLE, DEAD}
enum dialogue_states {IDLE_LOOP, ALERT_1, ALERT_LOOP}

const DIALOGUE_IDLE_LOOP = "res://dialogues/chapter_4/petrov_idle_loop.txt"
const DIALOGUE_ALERT_1 = "res://dialogues/chapter_4/petrov_alert_1.txt"
const DIALOGUE_ALERT_LOOP = "res://dialogues/chapter_4/petrov_alert_loop.txt"

func _ready():
	character_name = "petrov"
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.IDLE_LOOP:
			json_resource = DIALOGUE_IDLE_LOOP
			speak()
		dialogue_states.ALERT_1:
			json_resource = DIALOGUE_ALERT_1
			speak()
			dialogue_state = dialogue_states.ALERT_LOOP
		dialogue_states.ALERT_LOOP:
			json_resource = DIALOGUE_ALERT_LOOP
			speak()

func _on_Hurtbox_area_entered(area):
	if area.name == "Hurtbox": return
	
	state = states.DEAD
	death()

func on_weapon_equipped():
	dialogue_state = dialogue_states.ALERT_1
