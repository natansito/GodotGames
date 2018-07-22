extends Node2D

onready var globalVariables = get_node("/root/global")
onready var felpudo = get_node("Felpudo")
onready var timereplay = get_node("TimeToReplay")
onready var scors = get_node("Node2D/Control/Scors")
onready var life1 = get_node("Node2D/Control/Life1")
onready var life2 = get_node("Node2D/Control/Life2")
onready var life3 = get_node("Node2D/Control/Life3")


func _ready():
	pass
	
func kill():
	print(globalVariables.life)
	globalVariables.life -= 1
	
	if globalVariables.life == 2:
		life3.hide()
	if globalVariables.life == 1:
		life2.hide()
	if globalVariables.life == 0:
		life1.hide()
		felpudo.apply_impulse(Vector2(0,0), Vector2(-1000, 0))
		get_node("BackAnim").stop()
		globalVariables.state = globalVariables.LOSING
		#timereplay.start()
		get_node("SomHit").play()
		get_tree().change_scene("res://scenes/record.tscn")

	
func pontuar():
	globalVariables.score += 1
	scors.set_text(str(globalVariables.score))
	get_node("SomScore").play()

func _on_TimeToReplay_timeout():
	get_tree().reload_current_scene()