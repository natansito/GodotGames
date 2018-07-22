extends Node


func _ready():
	pass


func _on_Button_button_up():
	get_tree().change_scene("res://scene/menu.tscn")
