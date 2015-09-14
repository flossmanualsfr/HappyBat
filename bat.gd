
var reset_pos
var animation
export var speed = 100
export var gravity = 100
export var impulse_force = 200
var dead = false
var impulse_cur = 0
var level

func reset():
	set_global_pos(reset_pos)
	animation.play("fly")
	dead = false

func start():
	impulse_cur = 0
	set_process(true)
	set_process_input(true)
	impulse()
	dead = false

func die():
	animation.play("dead")
	dead = true
	set_process_input(false)
	level.bat_died()

func impulse():
	impulse_cur = impulse_force
	animation.play("impulse")

func stop():
	set_process(false)
	set_process_input(false)
		
func _process(time):
	var dir = Vector2()
	if !dead:
		dir.x = speed * time
	dir.y = -(impulse_cur - gravity) * time
	
	if impulse_cur > 0:
		impulse_cur -= gravity * time

	set_pos(get_pos() + dir)

func collided(obj):
	if obj.event_type == "point":
		level.add_point()
	elif obj.event_type == "damage":
		die()

func _input(event):
	if event.is_action("jump") && event.is_pressed() && !event.is_echo():
		impulse()

func _ready():
	# Initialization here
	reset_pos = get_global_pos()
	animation = get_node("animation")
	level = get_node("..")
