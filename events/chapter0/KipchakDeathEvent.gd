extends Node2D

signal one_down
signal all_down
signal leader_down

var death_counter: int = 0
var leader_down: bool = false

func on_kipchak_death():
	death_counter += 1
	$DeathTimer.start()

func on_leader_death():
	leader_down = true
	$LeaderDeathTimer.start()

func _on_DeathTimer_timeout():
	match death_counter:
		1: 
			emit_signal("one_down")
			var get_away_event = get_tree().get_nodes_in_group("get_away_event")[0]
			get_away_event.state = get_away_event.states.TRIGGERED
		3: 
			emit_signal("all_down")

func _on_LeaderDeathTimer_timeout():
	emit_signal("leader_down")
