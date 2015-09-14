export var spawn_distance = 500
export var min_obstacles = 50

var bat
var obstacles = []
var ui
var points = 0
var spawn_ofs = 1000

func _input(event):
	if event.is_action("restart") && event.is_pressed() && !event.is_echo():
		restart()

func restart():
	points = 0
	bat.reset()
	ui.reset()
	bat.start()
	emit_signal("game_reset")
	set_process(true)
	spawn_ofs = 1000
	get_node("animation").play("game_restart")
	
func _process(time):
	var bat_area = bat.get_node("area")
	var bat_rect = Rect2(bat_area.get_global_pos(), bat_area.get_size())
	for o in obstacles:
		var rect = o.get_rect()
		if rect.intersects(bat_rect):
			o.collided(bat)
			break

	while obstacles.size() < min_obstacles:
		spawn_obstacle()

func spawn_obstacle():
	var obs = preload("res://pipes_random.scn").instance()
	obs.set_pos(Vector2(spawn_ofs, 0))
	spawn_ofs += spawn_distance
	add_child(obs)
	printt("obstacle spawn at ", obs.get_pos())

func add_point():
	points += 1
	ui.set_points(points)

func spawn(obstacle):
	obstacles.push_back(obstacle)
	
func despawn(obstacle):
	obstacles.erase(obstacle)

func bat_died():
	get_node("animation").play("game_over")

func _ready():
	bat = get_node("bat")
	set_process_input(true)
	ui = get_node("ui")
	
	add_user_signal("game_reset")

