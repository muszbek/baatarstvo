extends "res://events/EventZone.gd"

const ENTER_YURT_SCRIPT = "enter_yurt"

onready var player = get_tree().get_nodes_in_group("player")[-1]
onready var entry_pos = get_tree().get_nodes_in_group("interior_entry_pos")[-1]

func _ready():
	dialogue.connect("script", self, "handle_script")

func handle_script(script_name):
	if state != states.TRIGGERED: return
	
	if script_name == ENTER_YURT_SCRIPT: teleport_player()

func teleport_player():
	player.set_deferred("global_position", entry_pos.global_position)
	$TeleportTimer.start()

func script_end():
	dialogue.emit_signal("next_line")

func _on_TeleportTimer_timeout():
	script_end()
