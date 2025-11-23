extends Node

var sounds = {
	"bounce": preload("res://resources/sounds/bounce.wav"),
	"button": preload("res://resources/sounds/button.wav"),
	"game_over": preload("res://resources/sounds/game_over.wav"),
	"game_won": preload("res://resources/sounds/game_won.wav"),
	"pt_loss": preload("res://resources/sounds/pt_loss.wav"),
	"pt_win": preload("res://resources/sounds/pt_win.wav")
}

var muted: bool = false

func toggle_mute() -> void:
	muted = !muted

func play(sound_name: String) -> void:
	if not sounds.has(sound_name) or muted: return
	var player := AudioStreamPlayer.new()
	player.stream = sounds[sound_name]
	if sound_name == "bounce": player.pitch_scale = randf_range(0.9, 1.1)
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)
