extends Node2D


onready var interval = get_node("Interval")
onready var limit = get_node("Limit")

var isGameOver = false
var pressed = false
var drag = false
var actualPosition = Vector2(0, 0)
var priorPosition = Vector2(0, 0)


func _ready():
	set_process_input(true)
	set_fixed_process(true)

func _fixed_process(delta):
	update()
	if drag and actualPosition != priorPosition and priorPosition != Vector2(0, 0) and not isGameOver:
		var space_state = get_world_2d().get_direct_space_state()
		var result = space_state.intersect_ray(priorPosition, actualPosition)
		if not result.empty():
			result.collider.cut()


func _input(event):
	event = make_input_local(event)
	if event.type == InputEvent.SCREEN_TOUCH:
		if event.pressed:
			pressed(event.pos)
		else:
			released()
	elif event.type == InputEvent.SCREEN_DRAG:
		drag(event.pos)


func pressed(pos):
	pressed = true
	priorPosition = pos
	interval.start()
	limit.start()


func released():
	pressed = false
	drag = false
	limit.stop()
	interval.stop()
	actualPosition = Vector2(0, 0)
	priorPosition = Vector2(0, 0)


func drag(pos):
	actualPosition = pos
	drag = true


func _on_Interval_timeout():
	priorPosition = actualPosition


func _on_Limit_timeout():
	released()


func _draw():
    if drag and actualPosition != priorPosition and priorPosition != Vector2(0, 0) and not isGameOver:
      draw_line(actualPosition, priorPosition, Color(1, 0, 0),10)










