extends Node

enum SCREEN { MAIN, DIFFICULTY, GAME }

const SCREEN_PATHS = {
	SCREEN.MAIN: "res://scenes/screens/main/main.tscn",
	SCREEN.DIFFICULTY: "res://scenes/screens/difficulty/difficulty.tscn",
	SCREEN.GAME: "res://scenes/screens/game/game.tscn"
}

var current_screen: SCREEN;


func load_scene(screen: SCREEN) -> void:
	var path = SCREEN_PATHS[screen]
	var new_scene = load(path).instantiate()
	var root = get_tree().current_scene
	if root.get_child_count() > 0:
		var old_page = root.get_child(0)
		old_page.queue_free()
	root.add_child(new_scene)
