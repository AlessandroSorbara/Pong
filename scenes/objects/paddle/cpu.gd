extends Paddle
class_name CPUPaddle

var difficulty_factor: int

func _ready():
	speed = Globals.difficulty_speeds[Globals.difficulty]
	difficulty_factor = Globals.difficulty_factor[Globals.difficulty]


func handle_move_logic() -> void:
	var distance_y = Globals.ball_position.y - position.y
	var movement_y = clamp(distance_y / difficulty_factor, -1, 1)
	direction = Vector2(0, movement_y)
