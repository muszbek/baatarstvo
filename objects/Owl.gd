extends "res://objects/Object.gd"

var used: bool = false

onready var game = get_tree().get_nodes_in_group("game")[-1]

func _on_Interactionbox_area_entered(_area):
	save_game()
	json_resource = DIALOGUE_LOOP
	use()

func save_game():
	if used:
		return
	
	game.save()
	used = true
