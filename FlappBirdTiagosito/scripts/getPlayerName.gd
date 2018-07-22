extends Node


onready var globalVariables = get_node("/root/global")
onready var txtPlayerName = get_node("txtGetPlayerName")


func _ready():
	pass


func _on_Ok_button_up():
	
	if txtPlayerName.get_text().length() > 0:
		globalVariables.playerName = txtPlayerName.get_text()


	#globalVariables.goto_scene("res://scenes/game.tscn")
	get_tree().change_scene("res://scenes/game.tscn")