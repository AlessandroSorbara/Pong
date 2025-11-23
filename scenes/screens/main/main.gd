extends Node2D

func _process(_delta: float) -> void:
	handle_sfx()


func handle_sfx() -> void:
	var sfx = $UI/CenterContainer/VBoxContainer/SFX
	if AudioManager.muted:
		sfx.text = "SFX: OFF"
	else:
		sfx.text = "SFX: ON"


func _on_singleplayer_pressed() -> void:
	AudioManager.play("button")
	Navigator.load_scene(Navigator.SCREEN.DIFFICULTY)


func _on_multiplayer_pressed() -> void:
	AudioManager.play("button")
	print("Coming Soon!")


func _on_sfx_pressed() -> void:
	AudioManager.play("button")
	AudioManager.toggle_mute()


func _on_exit_pressed() -> void:
	get_tree().quit()
