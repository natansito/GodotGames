extends Node2D

export var vel = -400
onready var globalVariables = get_node("/root/global")


var cena

func _ready():
	cena = get_tree().get_current_scene()
	set_process(true)
	
func _process(delta):
	if globalVariables.state == globalVariables.PLAYING:
		set_pos(get_pos() + Vector2(vel * delta, 0))
	
	if get_pos().x < -100:
		#print("Destruido!")
		queue_free()


func _on_Area2D_body_enter( body ):
	if body.get_name() == "Felpudo":
		cena.kill()


func _on_Ponto_body_enter( body ):
	#print("pontuamos")
	cena.pontuar()