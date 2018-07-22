extends RigidBody2D

var cena
onready var globalVariables = get_node("/root/global")


func _ready():
	cena = get_tree().get_current_scene()
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("touch"):
		on_touch()
		
func on_touch():
	if globalVariables.state == globalVariables.PLAYING:
		apply_impulse(Vector2(0, 0), Vector2(0, -1000))
		get_node("SomVoa").play()