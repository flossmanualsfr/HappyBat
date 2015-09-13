
export var top_range = Vector2(50, 200)
export var bottom_range = Vector2(300, 550)

var entered_screen = false

func exit_screen():
	if !entered_screen:
		return
	queue_free()

func enter_screen():
	entered_screen = true

func game_reset():
	queue_free()

func _ready():

	var top = top_range.x + randf() * (top_range.y - top_range.x)
	var bottom = bottom_range.x + randf() * (bottom_range.y - bottom_range.x)
	
	get_node("top").set_pos(Vector2(0, top))
	get_node("bottom").set_pos(Vector2(0, bottom))
	get_node("point").set_pos(Vector2(0, top))
	var s = get_node("point").get_size()
	get_node("point").set_size(Vector2(s.x, bottom - top))

	get_node("visibility").connect("exit_screen", self, "exit_screen")
	get_node("visibility").connect("enter_screen", self, "enter_screen")

	get_node("/root/level").connect("game_reset", self, "game_reset")