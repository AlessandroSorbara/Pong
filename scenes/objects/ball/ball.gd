extends CharacterBody2D
class_name Ball

@export var min_speed: int = 500
@export var max_speed: int = 1500
@export var speed_increment: int = 50
var speed: int
var direction: Vector2 = Vector2(1, 0).normalized()

func _ready() -> void:
	Globals.ball_position = global_position
	speed = min_speed
	direction = rand_launch_dir()


func _physics_process(delta: float) -> void:
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		AudioManager.play("bounce")
		var collider = collision.get_collider()
		if collider.is_in_group("Paddle"):
			direction = bounce_with_paddle(collision, collider)
			speed = min(speed + speed_increment, max_speed)
		else: 
			direction = direction.bounce(collision.get_normal()).normalized()
	Globals.ball_position = global_position


func rand_launch_dir() -> Vector2:
	var x = randf_range(0.6, 1.0) * Globals.ball_side
	var y = randf_range(-0.5, 0.5)
	Globals.ball_side *= -1
	return Vector2(x, y).normalized()


func bounce_with_paddle(collision, paddle) -> Vector2:
	var new_dir = direction.bounce(collision.get_normal())
	var offset  = (global_position.y - paddle.global_position.y) / (paddle.sprite_height / 2.0)
	offset = clamp(offset, -1, 1)
	new_dir.y = lerp(new_dir.y, offset * 0.7, 0.7)
	new_dir.y = clamp(new_dir.y, -0.8, 0.8)
	return new_dir.normalized()


func is_stuck() -> bool:
	return len($StuckArea.get_overlapping_bodies()) >= 2


func die() -> void:
	queue_free()
