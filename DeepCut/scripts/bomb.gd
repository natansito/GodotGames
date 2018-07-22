extends RigidBody2D

onready var sprite = get_node("Sprite")
onready var shape = get_node("Shape")
onready var animation = get_node("Animation")

signal life
var cuted = false


func _ready():
	set_process(true)
	randomize()


func _process(delta):
	if get_pos().y > 800:
		queue_free()


func born(initialPosition):
	set_pos(initialPosition)
	var initialVelocity = Vector2(0, rand_range(-1000, -800))
	if initialPosition.x < 640:
		initialVelocity = initialVelocity.rotated(deg2rad(rand_range(0, -30)))
	else:
		initialVelocity = initialVelocity.rotated(deg2rad(rand_range(0, 30)))

	set_linear_velocity(initialVelocity)
	set_angular_velocity(rand_range(-10, 10))


func cut():
	if cuted:
		return
	
	cuted = true
	emit_signal("life")
	set_mode(MODE_KINEMATIC)
	animation.play("Explode")
	print("Explodiu a Bomba!")








