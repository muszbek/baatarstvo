extends Node

export var chapter_path: String
export var chapter_screen_path: String

#warning-ignore:unused_signal
signal restart

var current_instance

func _ready():
	var _err = connect("restart", self, "on_restart")
	var screen = load_start_screen()
	yield(screen, "screen_finished")
	load_chapter()

func load_start_screen():
	var screen_loaded = load(chapter_screen_path)
	var screen_instance = screen_loaded.instance()
	add_child(screen_instance)
	return screen_instance

func load_chapter():
	var chapter_loaded = load(chapter_path)
	var chapter_instance = chapter_loaded.instance()
	add_child(chapter_instance)
	current_instance = chapter_instance

func on_restart():
	current_instance.queue_free()
	load_chapter()
