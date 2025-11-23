extends Node2D

func start_game() -> void:
	Navigator.load_scene(Navigator.SCREEN.GAME)


func _on_easy_pressed() -> void:
	AudioManager.play("button")
	Globals.difficulty = Globals.Difficulty.EASY
	start_game()


func _on_medium_pressed() -> void:
	AudioManager.play("button")
	Globals.difficulty = Globals.Difficulty.MEDIUM
	start_game()


func _on_hard_pressed() -> void:
	AudioManager.play("button")
	Globals.difficulty = Globals.Difficulty.HARD
	start_game()


func _on_back_pressed() -> void:
	AudioManager.play("button")
	Navigator.load_scene(Navigator.SCREEN.MAIN)
