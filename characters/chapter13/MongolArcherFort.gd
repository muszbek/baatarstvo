extends "res://characters/RangedEnemy.gd"

enum dialogue_states {ENTER, ATTACKED}
const DIALOGUE_LOOP = "res://dialogues/chapter_13/fort_guard_loop.txt"

func become_hostile():
	set_deferred("behavior", hostility.HOSTILE)
	dialogue_state = dialogue_states.ATTACKED

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_LOOP
			speak()
