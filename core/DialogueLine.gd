extends Control

enum states {WRITING, DONE}

onready var portrait_box = $PortraitBox
onready var portrait_sprite = $PortraitBox/PortraitSprite
onready var text_box = $Label
onready var text_player = $Label/AnimationPlayer
onready var dialogue = get_tree().get_nodes_in_group("dialogue")[-1]

var state = states.WRITING

func _process(_delta):
	next_line()

func init(side: String, portrait: Array, target: String, text: String):
	load_text(text)
	position(side)
	load_portrait(portrait)
	maybe_ping_target(target)

func load_portrait(texture_res_array: Array):
	if not texture_res_array: return
	
	clear_portrait()
	# An empty array is passed when we do not want to change the portrait
	if not "portrait" in portrait_sprite.frames.get_animation_names():
		portrait_sprite.frames.add_animation("portrait")

	for texture_res in texture_res_array:
		var frame = load(texture_res)
		portrait_sprite.frames.add_frame("portrait", frame)
	
	var portrait_fps = texture_res_array.size() / 2.0
	portrait_sprite.frames.set_animation_speed("portrait", portrait_fps)
	portrait_sprite.frames.set_animation_loop("portrait", true)
	portrait_sprite.play("portrait")
		
func clear_portrait():
	if portrait_sprite.frames.has_animation("portrait"):
		portrait_sprite.frames.clear("portrait")

func position(side: String):
	match side:
		"right":
			portrait_sprite.set_deferred("flip_h", false)
			portrait_box.set_position(Vector2(120.0, 8.0))
			portrait_box.set_deferred("visible", true)
			text_box.set_position(Vector2(8.0, 8.0))
		"left":
			portrait_sprite.set_deferred("flip_h", true)
			portrait_box.set_position(Vector2(8.0, 8.0))
			portrait_box.set_deferred("visible", true)
			text_box.set_position(Vector2(48.0, 8.0))
		"none":
			portrait_box.set_deferred("visible", false)
			text_box.set_position(Vector2(28.0, 8.0))
		"same":
			pass

func load_text(text: String):
	text_box.text = text
	text_player.play("show_text")

func _on_AnimationPlayer_animation_finished(_anim_name):
	state = states.DONE

func maybe_ping_target(target):
	if not target:
		return
	
	dialogue.emit_signal("dialogue_ping", target)
	
func next_line():
	if Input.is_action_just_pressed("interact"):
		match state:
			states.WRITING:
				text_player.stop()
				text_box.percent_visible = 1.0
				state = states.DONE
			states.DONE:
				dialogue.emit_signal("next_line")
				queue_free()
