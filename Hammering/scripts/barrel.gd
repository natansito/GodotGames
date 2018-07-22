extends Node2D



func _ready():
	pass


func barrelDestroyer(side):
	if side == -1:
		get_node("AnimationPlayer").play("moveToRight")
	else:
		get_node("AnimationPlayer").play("moveToLeft")	