extends "res://characters/MeleeEnemyStationary.gd"

const DIALOGUE_LOOP = "res://dialogues/chapter_6/persian_guard_loop.txt"

func _ready():
	var atabeg = get_tree().get_nodes_in_group("atabeg")[-1]
	atabeg.connect("atabeg_exited", self, "become_hostile")
	idle_animate()

func _on_Interactionbox_area_entered(_area):
	match behavior:
		hostility.PEACEFUL:
			json_resource = DIALOGUE_LOOP
			speak()
		hostility.HOSTILE:
			pass

func become_hostile():
	behavior = hostility.HOSTILE
