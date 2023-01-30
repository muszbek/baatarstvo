extends KinematicBody2D

enum directions {FRONT, BACK, LEFT, RIGHT}
enum states {MOVE, ATTACK, DIALOGUE, DEAD}

const DIALOGUE_DEATH = "res://dialogues/player_death.txt"

onready var game = get_tree().get_nodes_in_group("game")[-1]
export var speed: int = 24
export var facing = directions.FRONT
export var can_be_saved: bool = true
var state = states.MOVE
var movement_vector: Vector2 = Vector2.ZERO
var state_loaded: bool = false

signal dialogue(json_resource)

# Called when the node enters the scene tree for the first time.
func _ready():
	var dialogue = get_tree().get_nodes_in_group("dialogue")[-1]
	var _err = connect("dialogue", dialogue, "do_dialogue")
	dialogue.connect("dialogue_started", self, "dialogue_started")
	dialogue.connect("dialogue_finished", self, "dialogue_finished")
	load_on_start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		states.MOVE:
			facing_from_input()
			apply_facing()
			attack()
			move_by_input(delta)
			interact()
		states.ATTACK:
			pass
		states.DIALOGUE:
			pass

func facing_from_input():
	if Input.is_action_pressed("move_up"):
		facing = directions.BACK
	if Input.is_action_pressed("move_down"):
		facing = directions.FRONT
	if Input.is_action_pressed("move_left"):
		facing = directions.LEFT
	if Input.is_action_pressed("move_right"):
		facing = directions.RIGHT

func apply_facing():
	$PlayerBehavior.apply_facing(facing)

func attack():
	if Input.is_action_pressed("attack"):
		if is_pacific():
			return
		
		state = states.ATTACK
		$PlayerBehavior.attack_animate(facing)

func is_pacific():
	return $Pacificbox.get_overlapping_areas() != []

func attack_finished():
	if state == states.ATTACK:
		state = states.MOVE

func move_by_input(delta):
	var input_velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		input_velocity.x += 1
	if Input.is_action_pressed("move_left"):
		input_velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		input_velocity.y += 1
	if Input.is_action_pressed("move_up"):
		input_velocity.y -= 1

	input_velocity = input_velocity.normalized() * speed
	$PlayerBehavior.move_animate(facing, input_velocity)
		
	movement_vector = input_velocity * delta
	return move_and_collide(movement_vector)
	
func interact():
	if Input.is_action_just_pressed("interact"):
		$PlayerBehavior.interact_animate()

func _on_Hurtbox_area_entered(_area):
	death()
	
func dialogue_started():
	match state:
		states.MOVE, states.ATTACK:
			state = states.DIALOGUE
			$PlayerBehavior.idle_animate(facing)
		states.DEAD:
			pass
	
func dialogue_finished():
	match state:
		states.DIALOGUE:
			state = states.MOVE
		states.DEAD:
			game.current_chapter.emit_signal("restart")

func death():
	state = states.DEAD
	$CollisionShape2D.set_deferred("disabled", true)
	get_node("Hurtbox/CollisionShape2D").set_deferred("disabled", true)
	$PlayerBehavior.death_animate()
	emit_signal("dialogue", DIALOGUE_DEATH)

### Saving and loading state
func save_state():
	return {
		"pos": global_position,
		"facing": facing,
		"state": state,
		"dialogue_state": 0
	}

func load_state(dict):
	if not dict:
		return
	
	set_deferred("global_position", dict.get("pos"))
	facing = dict.get("facing")
	state = dict.get("state")
	state_loaded = true

func load_on_start():
	var data = game.saved_game.get(get_name())
	load_state(data)
