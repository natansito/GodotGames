extends Node 

onready var perc = get_node("personagem")
onready var camera = get_node("dead_camera")


func _ready():
	pass 
	
	
func change_camera():
	camera.set_global_pos(perc.get_node("camera").get_camera_pos())
	camera.make_current()

func _on_personagem_morreu():
	change_camera()
