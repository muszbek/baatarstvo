extends "res://characters/chapter2/RusSwordsmanSimple.gd"

enum dialogue_states {START, MOUNTED, LEARN_NEWS, LET_GO}
const DIALOGUE_ENTER = "res://dialogues/chapter_3/stablemaster_1.txt"
const DIALOGUE_LOOP_1 = "res://dialogues/chapter_3/stablemaster_loop_1.txt"
const DIALOGUE_LOOP_2 = "res://dialogues/chapter_3/stablemaster_loop_2.txt"
const DIALOGUE_LOOP_3 = "res://dialogues/chapter_3/stablemaster_loop_3.txt"

onready var horse_mount = get_tree().get_nodes_in_group("horse_mount")[-1]
onready var father = get_tree().get_nodes_in_group("father")[-1]

func _ready():
	character_name = "stablemaster"
	horse_mount.connect("mount_event", self, "on_mount_event")
	father.connect("father_let_go", self, "on_let_go")
	idle_animate()
	dialogue_state = dialogue_states.START

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.START:
			json_resource = DIALOGUE_ENTER
			speak()
		dialogue_states.MOUNTED:
			json_resource = DIALOGUE_LOOP_1
			speak()
		dialogue_states.LEARN_NEWS:
			json_resource = DIALOGUE_LOOP_2
			speak()
		dialogue_states.LET_GO:
			json_resource = DIALOGUE_LOOP_3
			speak()

func on_mount_event(): dialogue_state = dialogue_states.MOUNTED
func on_kipchak_talked(): dialogue_state = dialogue_states.LEARN_NEWS
func on_let_go(): dialogue_state = dialogue_states.LET_GO
