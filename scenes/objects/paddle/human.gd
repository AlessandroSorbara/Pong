extends Paddle
class_name HumanPaddle

func handle_move_logic() -> void:
	if Input.is_action_pressed("up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("down"):
		direction = Vector2.DOWN
	else:
		direction = Vector2.ZERO
