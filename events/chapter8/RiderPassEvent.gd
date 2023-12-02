extends "res://events/EventZone.gd"

const RIDER_NORTH_SCRIPT = "rider_passes_north"
const RIDER_HORIZONTAL_OFFSET = 88
const RIDER_NORTH_OFFSET = 30
const ANIMATION_LENGTH = 3.0

onready var player = get_tree().get_nodes_in_group("player")[-1]

var animated_rider = null
var spawn_offset = null

func _ready():
	dialogue.connect("script", self, "handle_script")

func handle_script(script_name):
	if state != states.TRIGGERED: return
	
	if script_name == RIDER_NORTH_SCRIPT: rider_north_animation()

func rider_north_animation():
	spawn_offset = Vector2(RIDER_HORIZONTAL_OFFSET, -RIDER_NORTH_OFFSET)
	animated_rider = get_node_or_null("RiderAnimation")
	animate_rider("rider_north")

func animate_rider(anim_name):
	var player_pos = player.get_global_position()
	var rider_pos = player_pos + spawn_offset
	var rider_end_pos = rider_pos + Vector2(-2 * RIDER_HORIZONTAL_OFFSET, 0)
	animated_rider.set_global_position(rider_pos)
	
	# add new animation
	var new_animation = Animation.new()
	new_animation.set_length(ANIMATION_LENGTH)
	$AnimationPlayer.add_animation(anim_name, new_animation)
	
	# add track for position interpolation
	var vt_index = new_animation.add_track(Animation.TYPE_VALUE)
	var animation_path = animated_rider.name + ":global_position:x"
	new_animation.track_set_path(vt_index, animation_path)
	new_animation.track_insert_key(vt_index, 0.0, rider_pos.x)
	new_animation.track_insert_key(vt_index, ANIMATION_LENGTH, rider_end_pos.x)
	
	$AnimationPlayer.play(anim_name)

func script_end():
	animated_rider.queue_free()
	dialogue.emit_signal("next_line")

func _on_AnimationPlayer_animation_finished(_anim_name):
	script_end()
