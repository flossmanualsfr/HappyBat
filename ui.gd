
func set_points(p_points):
	get_node("points").set_text(str(p_points))

func reset():
	set_points(0)

func _ready():
	reset()


