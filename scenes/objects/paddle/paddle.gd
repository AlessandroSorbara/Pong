extends StaticBody2D
class_name Paddle

@onready var sprite_width = $Sprite2D.texture.get_width() * $Sprite2D.scale.x
@onready var sprite_height = $Sprite2D.texture.get_height() * $Sprite2D.scale.y

var speed: float = 600
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	handle_move_logic()
	position.y += direction.y * speed * delta
	position.y = clamp(position.y, sprite_height / 2, get_viewport_rect().size.y - sprite_height / 2)


func handle_move_logic() -> void:
	pass
