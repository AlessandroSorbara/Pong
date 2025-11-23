extends CanvasLayer

func _ready() -> void:
	Globals.connect("point_scored", Callable(self, "update_ui"))
	update_ui()
	
	
func update_ui() -> void:
	$HumanPoints.text = str(Globals.game_pts["player"])
	$CPUPoints.text = str(Globals.game_pts["cpu"])
