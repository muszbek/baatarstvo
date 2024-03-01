extends "res://characters/Character.gd"

enum states {ENTER, ATTACKED, DEAD, KHATUN_KILLED}

const DIALOGUE_LOOP = "res://dialogues/chapter_12/shamans_loop.txt"
const DIALOGUE_ATTACKED = "res://dialogues/chapter_12/shamans_attacked.txt"
const DIALOGUE_END = "res://dialogues/chapter_12/shamans_end.txt"

const SCRIPT_NAME_1 = "shamans_talked"
const SCRIPT_NAME_2 = "shamans_attacked"

onready var khatun = get_tree().get_nodes_in_group("khatun")[-1]
signal shamans_talked
signal shamans_attacked

func _ready():
	character_name = "shaman_eagle"
	dialogue.connect("script", self, "handle_script")
	khatun.connect("khatun_killed", self, "on_khatun_killed")
	idle_animate()

func handle_script(script_name):
	match script_name:
		SCRIPT_NAME_1: 
			emit_signal("shamans_talked")
			$DialogueStepTimer.start()
		SCRIPT_NAME_2: 
			emit_signal("shamans_attacked")
			$DialogueStepTimer.start()
			state = states.ATTACKED

func _on_Interactionbox_area_entered(_area):
	match state:
		states.ENTER:
			json_resource = DIALOGUE_LOOP
			speak()
		states.KHATUN_KILLED:
			json_resource = DIALOGUE_END
			speak()

func _on_Hurtbox_area_entered(area):
	if area.name == "Hurtbox": return
	
	if state == states.ENTER:
		json_resource = DIALOGUE_ATTACKED
		speak()
	
	state = states.DEAD
	death()

func _on_DialogueStepTimer_timeout():
	dialogue.emit_signal("next_line")

func on_khatun_killed():
	state = states.KHATUN_KILLED
