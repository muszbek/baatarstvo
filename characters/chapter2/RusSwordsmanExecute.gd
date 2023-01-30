extends "res://characters/FollowerAlly.gd"

enum states {IDLE, AGGRESSIVE, ATTACK, FINISHED}
const SCRIPT_NAME = "execute_mongol"

func _ready():
	dialogue.connect("script", self, "handle_script")
	character_name = "rus_swordsman_execute"

func _physics_process(_delta):
	match state:
		states.IDLE:
			idle_animate()
		states.AGGRESSIVE:
			get_enemies_in_sight()
			if enemies_in_sight:
				get_closest_enemy_in_sight()
				aggro()
		states.ATTACK:
			pass
		states.FINISHED:
			idle_animate()

func handle_script(script_name):
	match script_name:
		SCRIPT_NAME: become_aggressive()

func become_aggressive(): state = states.AGGRESSIVE

func attack():
	state = states.ATTACK
	attack_animate()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ATTACK_ANIMATIONS:
		if state == states.ATTACK:
			state = states.AGGRESSIVE
