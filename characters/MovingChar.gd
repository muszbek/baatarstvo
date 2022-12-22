extends "res://characters/Character.gd"

var navigation: Navigation2D
var pathfinding: bool = false
var velocity: Vector2 = Vector2.ZERO
var navigation_target: Vector2
var path: Array = []

func get_navigation():
	navigation = get_tree().get_nodes_in_group("navigation")[-1]

func start_pathfinding():
	if pathfinding == false:
		get_navigation()
		pathfinding = true
		$NavigationTimer.start()

func stop_pathfinding():
	path = []
	velocity = Vector2.ZERO
	
	if pathfinding == true:
		pathfinding = false
		$NavigationTimer.stop()

func generate_path():
	path = navigation.get_simple_path(global_position, navigation_target, true)
	
func _on_NavigationTimer_timeout():
	generate_path()
	navigate()

func navigate():
	if path.size() > 1:
		velocity = global_position.direction_to(path[1]) * speed
		
		# if reached the first path point, remove it from the path Array
		if global_position == path[0]:
			path.pop_front()
	else:
		velocity = Vector2.ZERO

func move():
	adjust_facing_by_movement()
	move_animate(velocity)
	return move_and_slide(velocity)

func move_animate(movement_vector: Vector2):
	if movement_vector.length() > 0:
		walk_animate()
	else:
		idle_animate()
	
func adjust_facing_by_movement():
	if velocity == Vector2.ZERO:
		return
		
	var angle = velocity.angle()
	adjust_facing(angle)

func adjust_facing(angle):
	if angle > PI/4 and angle < PI * 3/4:
		facing = directions.FRONT
	elif angle < -PI/4 and angle > -PI * 3/4:
		facing = directions.BACK
	elif angle <= PI/4 and angle >= -PI/4:
		facing = directions.RIGHT
	elif angle >= PI * 3/4 or angle <= -PI * 3/4:
		facing = directions.LEFT

func walk_animate():
	if facing == directions.FRONT:
		sprite.animation = "walk_front"
	if facing == directions.BACK:
		sprite.animation = "walk_back"
	if facing == directions.LEFT:
		sprite.animation = "walk_left"
	if facing == directions.RIGHT:
		sprite.animation = "walk_right"
