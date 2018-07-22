extends Node2D


onready var fruits = get_node("Fruits")

var pineapple = preload("res://scenes/pineapple.tscn")
var avocado = preload("res://scenes/avocado.tscn")
var banana = preload("res://scenes/banana.tscn")
var lemon = preload("res://scenes/lemon.tscn")
var orange = preload("res://scenes/orange.tscn")
var pear = preload("res://scenes/pear.tscn")
var tomato = preload("res://scenes/tomato.tscn")
var watermelon = preload("res://scenes/watermelon.tscn")
var bomb = preload("res://scenes/bomb.tscn")

onready var score = get_node("ControlScore/Score")
onready var bomb1 = get_node("ControlScore/Bomb1")
onready var bomb2 = get_node("ControlScore/Bomb2")
onready var bomb3 = get_node("ControlScore/Bomb3")
onready var inputProc = get_node("InputProc")


var scoreValue = 0
var life = 3



func _ready():
	pass

var countType
func _on_Generrator_timeout():
	if life <- 0: return
	
	for i in range(0, rand_range(0, 6)):
		var type = int(rand_range(0, 9))
		var obj
		
		if type == 0:
			obj = avocado.instance()
			print("Avocado")
		elif type == 1:
			obj = banana.instance()
			print("Banana")
		elif type == 2:
			obj = lemon.instance()
			print("Lemon")
		elif type == 3:
			obj = orange.instance()
			print("Orange")
		elif type == 4:
			obj = pear.instance()
			print("Pear")
		elif type == 5:
			obj = pineapple.instance()
			print("Pineapple")
		elif type == 6:
			obj = tomato.instance()
			print("Tomato")
		elif type == 7:
			obj = watermelon.instance()
			print("Watermelon")
		elif type == 8:
			obj = bomb.instance()
			print("Bomb")

		obj.born(Vector2(rand_range(200, 1080), 800))
		obj.connect("life", self, "kill_life")
		
		if type != 8:
			obj.connect("score", self, "add_score")
			
		fruits.add_child(obj)


func kill_life():
	life -= 1
	if life == 0:
		print("Game Over")
		get_node("ControlGameOver").start()
		inputProc.isGameOver = true
		bomb1.set_modulate(Color(1, 0, 0))
		
	if life == 2:
		bomb3.set_modulate(Color(1, 0, 0))
	if life == 1:
		bomb2.set_modulate(Color(1, 0, 0))



func add_score():
	if life == 0:
		return
	
	scoreValue += 1
	score.set_text(str(scoreValue))






