extends "res://characters/Character.gd"

enum states {ENTER, ATTACKED, DEAD, KHATUN_KILLED}

const DIALOGUE_LOOP = "res://dialogues/chapter_12/shamans_loop.txt"
const DIALOGUE_ATTACKED = "res://dialogues/chapter_12/shamans_attacked.txt"
const DIALOGUE_END = "res://dialogues/chapter_12/shamans_end.txt"

onready var shaman_eagle = get_tree().get_nodes_in_group("shaman_eagle")[-1]
onready var khatun = get_tree().get_nodes_in_group("khatun")[-1]

func _ready():
	character_name = "shaman_wolf"
	shaman_eagle.connect("shamans_attacked", self, "on_shamans_attacked")
	khatun.connect("khatun_killed", self, "on_khatun_killed")
	idle_animate()

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

func on_shamans_attacked():
	if state == states.ENTER:
		state = states.ATTACKED

func on_khatun_killed():
	state = states.KHATUN_KILLED
