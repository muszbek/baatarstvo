extends "res://characters/chapter12/MongolNaginata.gd"

enum dialogue_states {ENTER, SHAMANS_ATTACKED}

const DIALOGUE_LOOP = "res://dialogues/chapter_12/mongol_naginata_shaman_loop.txt"

onready var shaman_eagle = get_tree().get_nodes_in_group("shaman_eagle")[-1]

func _ready():
	shaman_eagle.connect("shamans_attacked", self, "on_shamans_attacked")

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_LOOP
			speak()

func on_shamans_attacked():
	dialogue_state = dialogue_states.SHAMANS_ATTACKED
	set_deferred("behavior", hostility.HOSTILE)
