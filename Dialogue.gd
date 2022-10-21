extends Node2D

onready var player = $AnimationPlayer
onready var dialogue_container = $LowerBox
var dialogue_scene = preload("res://DialogueLine.tscn")

var json_resource
var active_line
var line_target
var line_portrait
var line_text
var line_side

signal dialogue_started
signal dialogue_finished
signal dialogue_ping(target)
signal script(script_name)
signal next_line

func start():
	player.play("box_float")
	emit_signal("dialogue_started")
	
func end():
	player.play_backwards("box_float")
	emit_signal("dialogue_finished")

func load_json(json_res: String):
	var json_file = File.new()
	json_file.open(json_res, File.READ)
	var json = json_file.get_as_text()
	json_file.close()
	return JSON.parse(json).result

func do_dialogue(resource_path: String):
	dialogue_reset()
	json_resource = load_json(resource_path)
	start()
	cycle_dialogue_lines(json_resource)

func cycle_dialogue_lines(lines):
	for line in lines:
		process_line(line)
		yield(self, "next_line")
	
	end()

func process_line(json_line):
	var script = json_line.get("script")
	
	if script:
		emit_signal("script", script)
	else:
		spawn_dialogue_line(json_line)

func spawn_dialogue_line(json_line):
	line_preload(json_line)
	active_line = dialogue_scene.instance()
	dialogue_container.add_child(active_line)
	active_line.init(line_side, line_portrait, line_target, line_text)

func line_preload(json_line: Dictionary):
	line_side = json_line.get("side", line_side)
	line_portrait = json_line.get("portrait", line_portrait)
	line_target = json_line.get("target", line_target)
	line_text = json_line.get("text")

func dialogue_reset():
	line_side = "same"
	line_portrait = []
	line_text = ""
	line_target = ""
