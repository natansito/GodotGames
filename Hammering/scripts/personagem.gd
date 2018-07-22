extends Node2D

onready var idle = get_node("Idle")
onready var strike = get_node("Strike")
onready var grave = get_node("Grave")
onready var animationPlayer = get_node("AnimationPlayer")


var side

const LEFT = -1
const RIGHT = 1


func _ready():
	pass


func left():
	set_pos(Vector2(220,1070))
	idle.set_flip_h(false)
	strike.set_flip_h(false)
	
	grave.set_pos(Vector2(-44, 41))
	grave.set_flip_h(true)
	side = LEFT


func right():
	set_pos(Vector2(500,1070))
	idle.set_flip_h(true)
	strike.set_flip_h(true)
	
	grave.set_pos(Vector2(28, 41))
	grave.set_flip_h(false)
	side = RIGHT


func striker():
	animationPlayer.play("ToStrike")


func toDie():
	animationPlayer.stop()
	idle.hide()
	strike.hide()
	grave.show()



