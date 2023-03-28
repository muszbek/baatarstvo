extends "res://events/EventZone.gd"

const SCRIPT_NAME = "mongol_catch_up"
const RIDER_START_OFFSET = 88
const RIDER_STOP_OFFSET = 24
const ANIMATION_LENGTH = 2.0

onready var player = get_tree().get_nodes_in_group("player")[-1]
var new_animation = null
var player_pos = null
var animated_riders = []

func _ready():
	dialogue.connect("script", self, "handle_script")

func handle_script(script_name):
	if state != states.TRIGGERED: return
	if script_name == SCRIPT_NAME: mongol_arrive_animation()

func mongol_arrive_animation():
	# add new animation
	new_animation =  Animation.new()
	new_animation.set_length(ANIMATION_LENGTH)
	$AnimationPlayer.add_animation("mongol_arrive", new_animation)
	
	player_pos = player.get_global_position()
	animate_leader()
	animate_rider1()
	animate_rider2()
	animate_rider3()
	animate_rider4()

	$AnimationPlayer.play("mongol_arrive")

func animate_leader():
	var animated_rider = get_node_or_null("MongolAnimationLeader")
	var spawn_offset = Vector2(-RIDER_START_OFFSET, 0)
	var end_offset = Vector2(-RIDER_STOP_OFFSET, 0)
	maybe_animate_rider(animated_rider, spawn_offset, end_offset)

func animate_rider1():
	var animated_rider = get_node_or_null("MongolAnimation1")
	var spawn_offset = Vector2(-RIDER_START_OFFSET, RIDER_STOP_OFFSET)
	var end_offset = Vector2(-RIDER_STOP_OFFSET, RIDER_STOP_OFFSET)
	maybe_animate_rider(animated_rider, spawn_offset, end_offset)

func animate_rider2():
	var animated_rider = get_node_or_null("MongolAnimation2")
	var spawn_offset = Vector2(-RIDER_START_OFFSET, -RIDER_STOP_OFFSET)
	var end_offset = Vector2(-RIDER_STOP_OFFSET, -RIDER_STOP_OFFSET)
	maybe_animate_rider(animated_rider, spawn_offset, end_offset)

func animate_rider3():
	var animated_rider = get_node_or_null("MongolAnimation3")
	var spawn_offset = Vector2(0, -RIDER_START_OFFSET)
	var end_offset = Vector2(0, -RIDER_STOP_OFFSET)
	maybe_animate_rider(animated_rider, spawn_offset, end_offset)

func animate_rider4():
	var animated_rider = get_node_or_null("MongolAnimation4")
	var spawn_offset = Vector2(0, RIDER_START_OFFSET)
	var end_offset = Vector2(0, RIDER_STOP_OFFSET)
	maybe_animate_rider(animated_rider, spawn_offset, end_offset)

func maybe_animate_rider(animated_rider, spawn_offset, end_offset):
	if animated_rider: add_track(animated_rider, spawn_offset, end_offset)

func add_track(animated_rider, spawn_offset, end_offset):
	animated_riders.append(animated_rider)
	var rider_pos = player_pos + spawn_offset
	var rider_end_pos = player_pos + end_offset
	animated_rider.set_global_position(rider_pos)
	animated_rider.walk_animate()
	
	# add track for position interpolation
	var vt_index_x = new_animation.add_track(Animation.TYPE_VALUE)
	var animation_path_x = animated_rider.name + ":global_position:x"
	new_animation.track_set_path(vt_index_x, animation_path_x)
	new_animation.track_insert_key(vt_index_x, 0.0, rider_pos.x)
	new_animation.track_insert_key(vt_index_x, ANIMATION_LENGTH, rider_end_pos.x)
	
	var vt_index_y = new_animation.add_track(Animation.TYPE_VALUE)
	var animation_path_y = animated_rider.name + ":global_position:y"
	new_animation.track_set_path(vt_index_y, animation_path_y)
	new_animation.track_insert_key(vt_index_y, 0.0, rider_pos.y)
	new_animation.track_insert_key(vt_index_y, ANIMATION_LENGTH, rider_end_pos.y)

func script_end():
	for rider in animated_riders: rider.idle_animate()
	dialogue.emit_signal("next_line")

func _on_AnimationPlayer_animation_finished(_anim_name):
	script_end()
