extends "res://characters/MeleeShieldChar.gd"

enum states {MOVE, ATTACK, DIALOGUE, DEAD}

const DIALOGUE_DEATH = "res://dialogues/player_death.txt"

onready var interaction_pivot = $InteractionboxPivot
onready var interaction_player = $InteractionboxPivot/Interactionbox/CollisionShape2D/InteractionPlayer

var movement_vector: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	var dialogue = get_tree().get_nodes_in_group("dialogue")[-1]
	dialogue.connect("dialogue_started", self, "dialogue_started")
	dialogue.connect("dialogue_finished", self, "dialogue_finished")
	state = states.MOVE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		states.MOVE:
			facing_from_input()
			interactionbox_from_facing()
			shield_from_facing()
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
		
func interactionbox_from_facing():
	match facing:
		directions.FRONT:
			interaction_pivot.rotation = 0
		directions.BACK:
			interaction_pivot.rotation = PI
		directions.LEFT:
			interaction_pivot.rotation = PI/2
		directions.RIGHT:
			interaction_pivot.rotation = -PI/2

func attack():
	if Input.is_action_pressed("attack"):
		if is_pacific():
			return
		
		state = states.ATTACK
		attack_animate()

func is_pacific():
	return $Pacificbox.get_overlapping_areas() != []

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ATTACK_ANIMATIONS:
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
	move_animate(input_velocity)
		
	movement_vector = input_velocity * delta
	return move_and_collide(movement_vector)
	
func interact():
	if Input.is_action_just_pressed("interact"):
		interaction_player.play("interaction")

func _on_Hurtbox_area_entered(_area):
	death()
	
func dialogue_started():
	match state:
		states.MOVE, states.ATTACK:
			state = states.DIALOGUE
			idle_animate()
		states.DEAD:
			pass
	
func dialogue_finished():
	match state:
		states.DIALOGUE:
			state = states.MOVE
		states.DEAD:
			game.emit_signal("restart")

func death():
	state = states.DEAD
	$CollisionShape2D.set_deferred("disabled", true)
	get_node("Hurtbox/CollisionShape2D").set_deferred("disabled", true)
	sprite.play("death")
	
	json_resource = DIALOGUE_DEATH
	emit_signal("dialogue", json_resource)
