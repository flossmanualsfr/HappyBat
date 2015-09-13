
var level
export var event_type = ""
export var single_shot = true

var collision_count = 0

func collided(obj):
	if single_shot && collision_count > 0:
		return
	collision_count += 1
	obj.collided(self)

func get_rect():
	if self extends Control:
		return Rect2(get_global_pos(), get_size())
	elif has_node("area"):
		var a = get_node("area")
		return Rect2(a.get_global_pos(), a.get_size())
	return null

func _exit_tree():
	level.despawn(self)

func _ready():
	level = get_node("/root/level")
	level.spawn(self)
	