extends Node

const START_SCREEN = "res://screens/StartScreen.tscn"
const TO_BE_CONTINUED_SCREEN = "res://screens/ToBeConinued.tscn"

var current_chapter_path = "res://map/chapter0/Chapter0Loader.tscn"
var current_chapter
var saved_game: Dictionary = {}

func _ready():
	var screen = load_start_screen()
	yield(screen, "start_screen_finished")
	load_chapter()

func load_start_screen():
	var start_screen_loaded = load(START_SCREEN)
	var start_screen_instance = start_screen_loaded.instance()
	add_child(start_screen_instance)
	return start_screen_instance

func load_chapter():
	var chapter_loaded = load(current_chapter_path)
	var chapter_instance = chapter_loaded.instance()
	add_child(chapter_instance)
	current_chapter = chapter_instance

func on_chapter_finish():
	current_chapter.queue_free()
	load_to_be_continued()

func load_to_be_continued():
	var screen_loaded = load(TO_BE_CONTINUED_SCREEN)
	var screen_instance = screen_loaded.instance()
	add_child(screen_instance)


func save():
	save_characters()
	save_events()
	save_player()

func save_characters():
	var characters: Array = get_tree().get_nodes_in_group("character")
	
	for character in characters:
		if not character.can_be_saved:
			return
		
		var id = character.get_name()
		var data: Dictionary = character.save_state()
		saved_game[id] = data

func save_events():
	var events: Array = get_tree().get_nodes_in_group("event")
	
	for event in events:
		var id = event.get_name()
		var data: Dictionary = event.save_state()
		saved_game[id] = data

func save_player():
	var player = get_tree().get_nodes_in_group("player")[-1]
	
	var data: Dictionary = player.save_state()
	saved_game["Player"] = data
