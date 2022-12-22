extends Control

onready var game = get_tree().get_nodes_in_group("game")[-1]
onready var left_widget = $LeftSprite
onready var right_widget = $RightSprite
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
		left_widget.animation = "empty"
	else:
		left_widget.animation = "left_arrow"
	
	if current_chapter == max_chapter:
		right_widget.animation = "locked"
	else:
		right_widget.animation = "right_arrow"
	
	label.text = "Chapter " + str(current_chapter)

func enable(): enabled = true
func disable(): enabled = false
