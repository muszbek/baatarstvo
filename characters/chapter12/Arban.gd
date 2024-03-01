extends "res://characters/Character.gd"

enum states {ENTER, SHAMANS_TALKED, SHAMANS_ATTACKED, KHATUN_ATTACKED}

const DIALOGUE_LOOP = "res://dialogues/chapter_12/arban_loop.txt"
const DIALOGUE_SHAMANS_ATTACKED = "res://dialogues/chapter_12/arban_shamans_attacked.txt"
const DIALOGUE_KHATUN_ATTACKED = "res://dialogues/chapter_12/arban_khatun_attacked.txt"

onready var shaman_eagle = get_tree().get_nodes_in_group("shaman_eagle")[-1]
onready var khatun = get_tree().get_nodes_in_group("khatun")[-1]
onready var shamans_talked_pos_target = get_tree().get_nodes_in_group("arban_shamans_talked_pos")[-1]
onready var shamans_attacked_pos_target = get_tree().get_nodes_in_group("arban_shamans_attacked_pos")[-1]
onready var khatun_attacked_pos_target = get_tree().get_nodes_in_group("arban_khatun_attacked_pos")[-1]

func _ready():
	shaman_eagle.connect("shamans_talked", self, "on_shamans_talked")
	shaman_eagle.connect("shamans_attacked", self, "on_shamans_attacked")
	khatun.connect("khatun_killed", self, "on_khatun_killed")

func _on_Interactionbox_area_entered(_area):
	match state:
		states.ENTER:
			json_resource = DIALOGUE_LOOP
			speak()
		states.SHAMANS_ATTACKED:
			json_resource = DIALOGUE_SHAMANS_ATTACKED
			speak()
		states.KHATUN_ATTACKED:
			json_resource = DIALOGUE_KHATUN_ATTACKED
			speak()

func on_shamans_talked():
	set_deferred("global_position", shamans_talked_pos_target.global_position)
	state = states.SHAMANS_TALKED

func on_shamans_attacked():
	set_deferred("global_position", shamans_attacked_pos_target.global_position)
	state = states.SHAMANS_ATTACKED

func on_khatun_killed():
	set_deferred("global_position", khatun_attacked_pos_target.global_position)
	state = states.KHATUN_ATTACKED
