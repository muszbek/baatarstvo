extends "res://characters/Character.gd"

enum states {ENTER, KHATUN_ATTACKED, SHAMANS_ATTACKED, DEAD}

const DIALOGUE_LOOP = "res://dialogues/chapter_12/khatun_loop.txt"
const DIALOGUE_END = "res://dialogues/chapter_12/khatun_end.txt"

onready var shaman_eagle = get_tree().get_nodes_in_group("shaman_eagle")[-1]
signal khatun_killed

func _ready():
	character_name = "khatun"
	shaman_eagle.connect("shamans_attacked", self, "on_shamans_attacked")
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	match state:
		states.ENTER:
			json_resource = DIALOGUE_LOOP
			speak()
		states.SHAMANS_ATTACKED:
			json_resource = DIALOGUE_END
			speak()

func _on_Hurtbox_area_entered(area):
	if area.name == "Hurtbox": return
	
	get_tree().call_group("khatun_soldiers", "on_khatun_attacked")
	emit_signal("khatun_killed")
	state = states.DEAD
	death()

func on_khatun_attacked():
	state = states.KHATUN_ATTACKED

func on_shamans_attacked():
	state = states.SHAMANS_ATTACKED
