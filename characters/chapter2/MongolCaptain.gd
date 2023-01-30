extends "res://characters/chapter2/MongolNaginata.gd"

func _ready():
	character_name = "mongol_captain"

func _physics_process(_delta):
	match state:
		states.IDLE:
			idle_animate()

func _on_Hurtbox_area_entered(_area):
	state = states.DEAD
	death()
	dialogue.emit_signal("next_line")
