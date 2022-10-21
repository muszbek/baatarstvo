extends KinematicBody2D

export var speed = 48
export var max_range = 64
const min_range = 4

var path = 0
var collision = null
# In the first few frames collision is not checked for.
# This serves to eliminate the problem of colliding with the archer at start.
var active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var velocity = Vector2(1.0, 0).rotated(rotation) * speed
	var movement_vector = velocity * delta
	path += movement_vector.length()
	
	check_min_range()
	check_max_range()
	collision = move_and_collide(movement_vector)
	check_for_collision()

func check_min_range():
	if active:
		return
	
	if path > min_range:
		$CollisionShape2D.set_deferred("disabled", false)
		$Hitbox/CollisionShape2D.set_deferred("disabled", false)
		active = true

func check_max_range():
	if path > max_range:
		queue_free()
		
func check_for_collision():
	if collision == null:
		return
		
	queue_free()

func _on_Hitbox_area_entered(_area):
	queue_free()
