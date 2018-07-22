extends Node2D

onready var globalVariables = get_node("/root/global")


func _ready():
	pass


func _on_Button_button_up():
	#globalVariables.goto_scene("res://scenes/game.tscn")
	get_tree().change_scene("res://scenes/getPlayerName.tscn")


func _on_Record_button_up():
	#globalVariables.goto_scene("res://scenes/game.tscn")
	get_tree().change_scene("res://scenes/record.tscn")


func _on_About_button_up():
	get_tree().change_scene("res://scenes/about.tscn")