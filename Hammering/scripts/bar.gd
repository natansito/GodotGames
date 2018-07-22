extends Node2D


onready var timeBar = get_node("TimeBar")

var percentTimeBar = 1

signal succumb

func _ready():
	set_process(true)


func _process(delta):
	if percentTimeBar > 0:
		percentTimeBar -= 0.08 * delta
		timeBar.set_region_rect(Rect2(0, 0, percentTimeBar * 188, 23))
		timeBar.set_pos(Vector2(-(1-percentTimeBar) * 188/2, 0))
	else:
		emit_signal("succumb")


func addTimeToTimeBar(delta):
	percentTimeBar += delta
	if percentTimeBar > 1:
		percentTimeBar = 1