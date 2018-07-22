extends Position2D


onready var obstaculo = preload("res://scene/obstaculo.tscn")


func _ready():
	randomize()


func _on_Timer_timeout():
	var novoObstaculo = obstaculo.instance()
	novoObstaculo.set_pos(get_pos() + Vector2(0, rand_range(-200, 200)))
	get_owner().add_child(novoObstaculo)
