extends Node

# Difficulty
enum Difficulty { EASY, MEDIUM, HARD }

var difficulty_speeds = {
	Difficulty.EASY: 500,
	Difficulty.MEDIUM: 600,
	Difficulty.HARD: 700
}

var difficulty_factor = {
	Difficulty.EASY: 200,
	Difficulty.MEDIUM: 150,
	Difficulty.HARD: 100
}

var difficulty: Difficulty

# Game Points
signal point_scored

var game_pts = {
	"player": 0,
	"cpu": 0
}

func score(key: String) -> void:
	game_pts[key] += 1
	point_scored.emit()

func reset_game_pts() -> void:
	game_pts["player"] = 0
	game_pts["cpu"] = 0

# Ball
var ball_position: Vector2

var ball_side: int = -1
