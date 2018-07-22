extends Node


var barrel = preload("res://scene/barrel.tscn")
var leftBarrel = preload("res://scene/leftBarrel.tscn")
var rightBarrel = preload("res://scene/rightBarrel.tscn")

onready var bar = get_node("Bar")
onready var camera = get_node("Camera")
onready var barrels = get_node("Barrels")
onready var life1 = get_node("Bar/Life1")
onready var life2 = get_node("Bar/Life2")
onready var life3 = get_node("Bar/Life3")
onready var personagem = get_node("Personagem")
onready var lblScores = get_node("Control/Scores")
onready var playerName = get_node("Control/PlayerName")
onready var destinationBarrels = get_node("DestinationBarrels")
onready var record = get_node("Control/ControlDieInformation/Record")
onready var playAgain = get_node("Control/ControlDieInformation/PlayAgain")
onready var controlDieInformation = get_node("Control/ControlDieInformation")

var lifes = 3
var scores = 0
var lastBarrelIsEnemy
var gameState = PLAYING
var scorePlusPlus = false
var alreadyLostLife = false

const PLAYING = 0
const LOSING = 1


func _ready():
	randomize()
	set_process_input(true)
	initialBarrels()
	controlDieInformation.hide()
	bar.connect("succumb",self, "gameOver")


func _input(event):
	event = camera.make_input_local(event)
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed and gameState == PLAYING:
		if event.pos.x < 360:
			personagem.left()
		else:
			personagem.right()
		
		if !checkIfTouchEnemy() or lifes != 0:
			updateBarrels()
			
			if checkIfTouchEnemy() and lifes == 0:
				gameOver()
		elif lifes == 0:
			gameOver()


func updateBarrels():
	personagem.striker()
	var firstBarrel = barrels.get_children()[0]
	barrels.remove_child(firstBarrel)
	destinationBarrels.add_child(firstBarrel)
	firstBarrel.barrelDestroyer(personagem.side)
	randomizeBarrels(Vector2(360, 1090 - 10*172))
	goDownBarrels()
	
	if firstBarrel.is_in_group("left_Group") or firstBarrel.is_in_group("right_Group"):
		bar.addTimeToTimeBar(0.10)
	
	bar.addTimeToTimeBar(0.054)
	
	scores += 1
	lblScores.set_text(str(scores))


func randomizeBarrels(positon):
	var numberRandon = rand_range(0,3)
	if lastBarrelIsEnemy:
		numberRandon = 0
	
	barrelGenerator(int(numberRandon), positon)


func barrelGenerator(type, position):
	var newBarrel
	if type == 0:
		lastBarrelIsEnemy = false
		newBarrel = barrel.instance()
	if type == 1:
		lastBarrelIsEnemy = true
		newBarrel = leftBarrel.instance()
		newBarrel.add_to_group("left_Group")
	if type == 2:
		lastBarrelIsEnemy = true
		newBarrel = rightBarrel.instance()
		newBarrel.add_to_group("right_Group")
	
	newBarrel.set_pos(position)
	barrels.add_child(newBarrel)


func initialBarrels():
	for i in range(0, 1):
		barrelGenerator(0, Vector2(360, 1090 - i * 172))
	
	for i in range(1, 10):
		randomizeBarrels(Vector2(360, 1090 - i * 172))


func checkIfTouchEnemy():
	
	if alreadyLostLife == true:
		updateBarrels()
		alreadyLostLife = false
		return false
	
	var side = personagem.side
	var firstBarrel = barrels.get_children()[0]
	if side == personagem.LEFT and firstBarrel.is_in_group("left_Group") or side == personagem.RIGHT and firstBarrel.is_in_group("right_Group"):
		lifes -= 1
		alreadyLostLife = true
		
		resetBarTime()
		updateLifes()
		
		return true
	else:
		return false


func updateLifes():
	if lifes == 2:
		life3.hide()
	if lifes == 1:
		life2.hide()
	if lifes == 0:
		life1.hide()


func resetBarTime():
	bar.addTimeToTimeBar(1)


func goDownBarrels():
	for b in barrels.get_children():
		b.set_pos(b.get_pos() + Vector2(0, 172))


func gameOver():
	if lifes > 0:
		resetBarTime()
		lifes -= 1
		updateLifes()
		
		if lifes == 0:
			sotopGameOver()
	else:
		sotopGameOver()


func sotopGameOver():
	personagem.toDie()
	bar.set_process(false)
	gameState = LOSING
	controlDieInformation.show()


func _on_PlayAgain_button_up():
	get_tree().reload_current_scene()
