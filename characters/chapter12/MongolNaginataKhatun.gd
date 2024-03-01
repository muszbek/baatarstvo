extends "res://characters/chapter12/MongolNaginata.gd"

enum dialogue_states {ENTER, KHATUN_ATTACKED}

const DIALOGUE_LOOP = "res://dialogues/chapter_12/mongol_naginata_khatun_loop.txt"

func _on_Interactionbox_area_entered(_area):
	match dialogue_state:
		dialogue_states.ENTER:
			json_resource = DIALOGUE_LOOP
			speak()

func _on_Hurtbox_area_entered(area):
	if area.name == "Hurtbox": return
	
	get_tree().call_group("khatun_soldiers", "on_khatun_attacked")
	state = states.DEAD
	stop_pathfinding()
	death()

func on_khatun_attacked():
	if dialogue_state == dialogue_states.ENTER:
		dialogue_state = dialogue_states.KHATUN_ATTACKED
		set_deferred("behavior", hostility.HOSTILE)
