extends Control

onready var game = get_tree().get_nodes_in_group("game")[-1]
onready var left_widget = $LeftSprite
onready var right_widget = $RightSprite
onready var locked_widget = $LockedSprite
onready var label = $Label

var current_chapter: int = 0
var max_chapter: int
var enabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	max_chapter = game.get_max_chapter()
	display_chapter()

func _process(_delta):
	if Input.is_action_just_pressed("move_left"): 
		if enabled: prev_chapter()
	
	if Input.is_action_just_pressed("move_right"): 
		if enabled: next_chapter()

func prev_chapter():
	if current_chapter > 0: current_chapter -= 1
	display_chapter()

func next_chapter():
	if current_chapter < max_chapter: current_chapter += 1
	display_chapter()

func display_chapter():
	if current_chapter == 0:
		left_widget.set_deferred("visible", false)
	else:
		left_widget.set_deferred("visible", true)
	
	if current_chapter == max_chapter:
		right_widget.set_deferred("visible", false)
		#locked_widget.set_deferred("visible", true)
	else:
		right_widget.set_deferred("visible", true)
		#locked_widget.set_deferred("visible", false)
	
	chapter_label()

func chapter_label():
	if current_chapter != max_chapter:
		label.text = "Chapter " + str(current_chapter)
	else:
		label.text = "Epilogue"

func enable(): enabled = true
func disable(): enabled = false
