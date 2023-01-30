extends "res://characters/chapter2/RusSwordsmanSimple.gd"

enum states {START, MOUNTED}
const DIALOGUE_LOOP_1 = "res://dialogues/chapter_2/stablemaster_loop_1.txt"
const DIALOGUE_LOOP_2 = "res://dialogues/chapter_2/stablemaster_loop_2.txt"

onready var horse_mount = get_tree().get_nodes_in_group("horse_mount")[-1]

func _ready():
	character_name = "stablemaster"
	horse_mount.connect("mount_event", self, "on_mount_event")
	idle_animate()
	state = states.START

func _on_Interactionbox_area_entered(_area):
	match state:
		states.START:
			json_resource = DIALOGUE_LOOP_1
			speak()
		states.MOUNTED:
			json_resource = DIALOGUE_LOOP_2
			speak()

func on_mount_event(): state = states.MOUNTED
