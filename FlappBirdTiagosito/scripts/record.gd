extends Node2D


onready var globalVariables = get_node("/root/global")
onready var lblHighScoreName = get_node("Control/HighScoreName")
onready var lblHighScoreValue = get_node("Control/HighScoreValue")
onready var lblCurrentScoreName = get_node("Control/CurrentScoreName")
onready var lblCurrentScoreValue = get_node("Control/CurrentScoreValue")
onready var btnClearHistory = get_node("Control/ClearHistory")

var newName = ""
var newScore = 0
var oldName = ""
var oldScore = 0
var changePositions = false
var highScoreLocal = 0
var currentScoreLocal = 0


func _ready():
	if not globalVariables.savegame.file_exists(globalVariables.save_path):
		create_save()

	setValues()


func setValues():
	setBtnClearHistoryInvisible(true)
	setInvisibleHighScoreValues(false)
	setInvisibleCurrentScoreValues(true)
	setHighScoreValue()
	setHighScoreName()
	setCurrentScoreName()
	setCurrentScoreValue()
	organizeDisplayValues()


func setBtnClearHistoryInvisible(isInvisible):
	btnClearHistory.set_hidden(isInvisible)


func setInvisibleHighScoreValues(isInvisible):
	lblHighScoreName.set_hidden(isInvisible)
	lblHighScoreValue.set_hidden(isInvisible)


func setInvisibleCurrentScoreValues(isInvisible):
	lblCurrentScoreName.set_hidden(isInvisible)
	lblCurrentScoreValue.set_hidden(isInvisible)


func setHighScoreName():
	lblHighScoreName.set_text(read_HighScorePlayerName())


func setHighScoreValue():
	newName = globalVariables.playerName #Show the previous and the new player who scored
	newScore = globalVariables.score #Show the previous and the new player who scored
	oldName = read_HighScorePlayerName() #Show the previous and the new player who scored
	oldScore = read_HighScore() #Show the previous and the new player who scored
	highScoreLocal = oldScore

	saveNewValues()
	
	highScoreLocal = read_HighScore()
	lblHighScoreValue.set_text(str(highScoreLocal))


func saveNewValues():
	if highScoreLocal < globalVariables.score:
		saveHighScore() #Save new Socore
		saveHighScorePlayerName() #Save new Player Name
		if oldScore > 0:
			changePositions = true #To change position between current player and old player that scored max point
	else:
		oldScore = read_HighScore()

func setCurrentScoreName():
	lblCurrentScoreName.set_text(globalVariables.playerName)


func setCurrentScoreValue():
	currentScoreLocal = globalVariables.score
	lblCurrentScoreValue.set_text(str(currentScoreLocal))


func organizeDisplayValues():
	if oldScore == 0:
		setInvisibleCurrentScoreValues(true)
	else:
		setInvisibleCurrentScoreValues(false)

	if globalVariables.score >= 50:
		setBtnClearHistoryInvisible(false)
	else:
		setBtnClearHistoryInvisible(true)

	if changePositions == true:
		lblHighScoreName.set_text(newName)
		lblHighScoreValue.set_text(str(newScore))
		lblCurrentScoreName.set_text(oldName)
		lblCurrentScoreValue.set_text(str(oldScore))


func _on_PlayAgain_button_up():
	#globalVariables.goto_scene("res://scenes/game.tscn")
	globalVariables.restartValues()
	get_tree().change_scene("res://scenes/game.tscn")


func _on_NewName_button_up():
	globalVariables.restartValues()
	get_tree().change_scene("res://scenes/getPlayerName.tscn")


func _on_Menu_button_up():
	globalVariables.restartValues()
	get_tree().change_scene("res://scenes/menu.tscn")


func _on_ClearHistory_button_up():
	delete_HighScore()
	setBtnClearHistoryInvisible(true)
	lblCurrentScoreName.hide()
	lblCurrentScoreValue.hide()





######################### Save data scores #########################
func create_save():
	globalVariables.savegame.open(globalVariables.save_path, File.WRITE)
	globalVariables.savegame.store_var(globalVariables.save_data)
	globalVariables.savegame.close()


func saveHighScore():
	if globalVariables.score == null || globalVariables.score < 1:
		globalVariables.score = 0
	
	globalVariables.save_data["highscoreKey"] = globalVariables.score #data to save
	globalVariables.savegame.open(globalVariables.save_path, File.WRITE) #open file to write
	globalVariables.savegame.store_var(globalVariables.save_data) #store the data
	globalVariables.savegame.close() # close the file


func saveHighScorePlayerName():
	if globalVariables.playerName == null || str(globalVariables.playerName).length() < 1:
		globalVariables.playerName = "Timão"
	
	globalVariables.save_data["playernameKey"] = globalVariables.playerName #data to save
	globalVariables.savegame.open(globalVariables.save_path, File.WRITE) #open file to write
	globalVariables.savegame.store_var(globalVariables.save_data) #store the data
	globalVariables.savegame.close() # close the file


func read_HighScore():
	if globalVariables.highscore != null:
		globalVariables.savegame.open(globalVariables.save_path, File.READ) #open the file
		globalVariables.save_data = globalVariables.savegame.get_var() #get the value
		globalVariables.savegame.close() #close the file
		return globalVariables.save_data["highscoreKey"] #return the value
	else:
		return 0


func read_HighScorePlayerName():
	if globalVariables.playerName != null && str(globalVariables.playerName).length() > 0:
		globalVariables.savegame.open(globalVariables.save_path, File.READ) #open the file
		globalVariables.save_data = globalVariables.savegame.get_var() #get the value
		globalVariables.savegame.close() #close the file
		return globalVariables.save_data["playernameKey"] #return the value
	else:
		return "Timão"


func delete_HighScore():
	if globalVariables.savegame.file_exists(globalVariables.save_path):
		globalVariables.directory.remove(globalVariables.save_path)
