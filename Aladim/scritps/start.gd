extends Node2D


onready var btnPlay = get_node("Play")
onready var btnAbout = get_node("About")


func _ready():
	pass


func _on_Play_button_up():
	get_tree().change_scene("res://scene/menu.tscn")


func _on_About_button_up():
	get_tree().change_scene("res://scene/about.tscn")
