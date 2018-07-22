extends Node2D

onready var btnPlay = get_node("Control/Play") #Conecta o componente ao codigo
onready var fisica = get_node("Control/Fisica")
onready var lblPontos = get_node("Node2D/lblPontos")
onready var vida1 = get_node("Node2D/vida1")
onready var vida2 = get_node("Node2D/vida2")
onready var vida3 = get_node("Node2D/vida3")
onready var backAnim = get_node("BackAnim")
onready var restartGame = get_node("RestartGame")

var pontos = 0
var estado = 1
var vidas = 9999

const JOGANDO = 1
const PERDENDO = 2


func _ready():
	#get_node("voando").play()
	pass


func kill():

	vidas -= 1
	
	if vidas == 0:
		fisica.apply_impulse(Vector2(0,0), Vector2(-1000,0))
		backAnim.stop()
		estado = PERDENDO
		restartGame.start()
	else:
		apagaVidas()


func apagaVidas():
	if vidas == 2:
		vida3.hide()
	if vidas == 1:
		vida2.hide()
	if vidas == 0:
		vida1.hide()


func pontuar():
	var oldPontos = pontos
	pontos += 1
	lblPontos.set_text(str(pontos))
	if pontos == oldPontos +2:
		print("Ferrrrrouziussss")


func _on_RestartGame_timeout():
	get_tree().reload_current_scene()
