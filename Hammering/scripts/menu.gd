extends Node2D


func _ready():
	pass


func _on_Play_button_up():
	get_tree().change_scene("res://scene/game.tscn")


func _on_About_button_up():
	get_tree().change_scene("res://scene/about.tscn")
