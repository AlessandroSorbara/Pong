extends Node2D

@onready var ball_scene: PackedScene = load("res://scenes/objects/ball/ball.tscn")
var ball: CharacterBody2D
var ball_respawn: bool = false
var game_pts: int = 10

func _ready() -> void:
	$PauseMenu.hide()
	$WinMenu.hide()
	position_paddles()
	ball = $Ball
	position_ball()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().paused = true
		$PauseMenu.show()
	if ball and ball.is_stuck():
		resolve_stuck()
	handle_game_end()


func position_paddles() -> void:
	var w = get_viewport_rect().size.x
	var h = get_viewport_rect().size.y
	var p = $Human.sprite_width
	
	$Human.position = Vector2(p / 2.0, h / 2.0)
	$CPU.position = Vector2(w - (p / 2.0), h / 2.0)


func position_ball() -> void:
	ball.position = get_viewport_rect().size / 2


func new_ball() -> void:
	ball.die()
	ball = ball_scene.instantiate()
	ball_respawn = true
	add_child(ball)
	position_ball()


func handle_game_end() -> void:
	var player_pts = Globals.game_pts["player"]
	var cpu_pts = Globals.game_pts["cpu"]
	if player_pts >= game_pts or cpu_pts >= game_pts:
		ball.queue_free()
		var winner: String = "PLAYER" if player_pts > cpu_pts else "CPU"
		var has_player_won: bool = winner == "PLAYER"
		get_tree().paused = true
		$WinMenu/Panel/VBoxContainer/Label.text = winner + " WON!"
		if has_player_won:
			$WinMenu/Panel/VBoxContainer/Label.modulate = Color("00ff00")
			AudioManager.play("game_won")
		else:
			$WinMenu/Panel/VBoxContainer/Label.modulate = Color("ff0000")
			AudioManager.play("game_over")
		$WinMenu.show()


func resolve_stuck() -> void:
	if ball.position.x < 600:
		_on_left_body_entered(ball)
	else:
		_on_right_body_entered(ball)


func _on_left_body_entered(_body: Node2D) -> void:
	if not ball_respawn: 
		Globals.score("cpu")
		AudioManager.play("pt_loss")
		call_deferred("new_ball")
		$BallRespawnCooldown.start()


func _on_right_body_entered(_body: Node2D) -> void:
	if not ball_respawn:
		Globals.score("player")
		AudioManager.play("pt_win")
		call_deferred("new_ball")
		$BallRespawnCooldown.start()


func _on_ball_respawn_cooldown_timeout() -> void:
	ball_respawn = false
	

func _on_resume_pressed() -> void:
	AudioManager.play("button")
	$PauseMenu.hide()
	get_tree().paused = false


func _on_quit_pressed() -> void:
	AudioManager.play("button")
	Navigator.load_scene(Navigator.SCREEN.MAIN)
	get_tree().paused = false
	Globals.reset_game_pts()
	Globals.ball_side = -1
