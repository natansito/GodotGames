extends RigidBody2D

onready var sprite0 = get_node("Sprite0")
onready var shape = get_node("Shape")
onready var body1 = get_node("Body1")
onready var body2 = get_node("Body2")
onready var sprite1 = get_node("Body1/Sprite1")
onready var sprite2 = get_node("Body2/Sprite2")

var truncated = false
signal score
signal life

func _ready():
	randomize()
	set_process(true)


func _process(delta):
	if get_pos().y > 800:
		print("Perdeu Play Boy")
		emit_signal("life")
		queue_free()
	
	if body1.get_pos().y > 800 and body2.get_pos().y > 800:
		print("Free!")
		queue_free()
		
		


func born (initialPosition):
	set_pos(initialPosition)
	var initialVelocity = Vector2(0, rand_range(-1000, -800))
	if initialPosition.x < 640:
		initialVelocity = initialVelocity.rotated(deg2rad(rand_range(0, -30)))
	else:
		initialVelocity = initialVelocity.rotated(deg2rad(rand_range(0, 30)))

	set_linear_velocity(initialVelocity)
	set_angular_velocity(rand_range(-10, 10))


func cut():
	if truncated:
		return
	else:
		truncated = true
	
	
	emit_signal("score")
	
	set_mode(MODE_KINEMATIC)
	sprite0.queue_free()
	shape.queue_free()
	body1.set_mode(MODE_RIGID)
	body2.set_mode(MODE_RIGID)
	body1.apply_impulse(Vector2(0,0), Vector2(-100, 0).rotated(get_rot()))
	body2.apply_impulse(Vector2(0,0), Vector2(100, 0).rotated(get_rot()))
	body1.set_angular_velocity(get_angular_velocity())
	body2.set_angular_velocity(get_angular_velocity())
