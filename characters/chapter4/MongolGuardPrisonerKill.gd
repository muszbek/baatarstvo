extends "res://characters/chapter4/MongolNaginata.gd"

enum script_states {IDLE, KILLING, STRIKING, KILLED, GO_TO_TARGET, ARRIVED}
const SCRIPT_NAME = "guard_run"

onready var run_target = get_tree().get_nodes_in_group("mongol_guard_run_pos")[-1]
onready var prisoner_coward = get_tree().get_nodes_in_group("prisoner_coward")[-1]
var script_state = script_states.IDLE

func _ready():
	prisoner_coward.connect("kill_prisoner_coward", self, "on_kill_prisoner")
	prisoner_coward.connect("prisoner_death", self, "on_prisoner_death")
	dialogue.connect("script", self, "handle_script")

func call_physics_process():
	match script_state:
		script_states.IDLE:
			idle_animate()
		script_states.KILLING:
			if not pathfinding: start_pathfinding()
			
			move()
			attack_on_contact()
		script_states.GO_TO_TARGET:
			if run_target.global_position.distance_to(global_position) < 1:
				stop_pathfinding()
				script_state = script_states.ARRIVED
				arrive_action()
			move()

func on_kill_prisoner():
	navigation_target = prisoner_coward.global_position
	los.look_at(navigation_target)
	script_state = script_states.KILLING

func attack_on_contact():
	collision = get_last_slide_collision()
	if not collision: return
	
	if collision.get_collider().is_in_group("prisoner_coward"): 
		attack()
		script_state = script_states.STRIKING

func on_prisoner_death():
	script_state = script_states.KILLED
	stop_pathfinding()
	dialogue.emit_signal("next_line")

func handle_script(script_name):
	if script_name == SCRIPT_NAME: run()

func run():
	navigation_target = run_target.global_position
	start_pathfinding()
	script_state = script_states.GO_TO_TARGET

func arrive_action():
	state = states.REMOVED
	remove()
	dialogue.emit_signal("next_line")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ATTACK_ANIMATIONS:
		if script_state == script_states.KILLED:
			script_state = script_states.IDLE
