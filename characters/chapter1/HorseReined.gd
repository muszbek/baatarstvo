extends "res://characters/Character.gd"

enum states {START, LEAVE}

const DIALOGUE_LOOP = "res://dialogues/chapter_1/horse_reined_loop.txt"
signal chapter_finish_anim

onready var stanislav = get_tree().get_nodes_in_group("stanislav")[-1]
onready var fullscreen_anim = get_tree().get_nodes_in_group("fullscreen_anim")[-1]

func _ready():
	if facing == directions.RIGHT:
		sprite.flip_h = true
	
	var _err = connect("chapter_finish_anim", fullscreen_anim, "on_chapter_finish")
	stanislav.connect("leave_horse", self, "ready_to_leave")

func ready_to_leave():
	state = states.LEAVE

func _on_Interactionbox_area_entered(_area):
	match state:
		states.START:
			json_resource = DIALOGUE_LOOP
			speak()
		states.LEAVE:
			emit_signal("chapter_finish_anim")
