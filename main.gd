extends Node2D

#Loads scenes and music into the script and makes them callable as variables

@onready var game_over = $CanvasLayer/CenterContainer/GameOver
@onready var battle_music = $BattleMusic
@onready var start = $CanvasLayer/CenterContainer/Start
@onready var spawner = $"enemy spawner"
@onready var game_over_music = $GameOverMusic
@onready var player = $Character
@onready var winning_music = $WinningMusic


# Called when the node enters the scene tree for the first time.
func _ready():
	#UI.set_process_mode(UI.PROCESS_MODE_DISABLED)
	#game_over.hide() #Hides the Game Over Texture
	#start.show() #Shows the Start Texture
	spawner.set_process_mode(spawner.PROCESS_MODE_DISABLED) #Disables the spawner scene
	player.set_process_mode(player.PROCESS_MODE_DISABLED) #Disables the player scene
	player.hide() #Hides the player scene

func new_game():
	player.show() #Shows the player
	#UI.set_process_mode(UI.PROCESS_MODE_ALWAYS)
	battle_music.play() #Plays the Battle music
	player.set_process_mode(player.PROCESS_MODE_ALWAYS) #Enables the Player scene
	spawner.set_process_mode(spawner.PROCESS_MODE_ALWAYS) #Enables the Spawner
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _end_game():
	pass


func _on_character_died():
	print ("Died") #Prints Died to see if the signal works
	$UI.game_done()  #Shows the Game Over Texture
	#UI.set_process_mode(UI.PROCESS_MODE_DISABLED)
	spawner.set_process_mode(spawner.PROCESS_MODE_DISABLED) #Disables the Spawner Scene
	spawner.hide() #Hides the Spawner Scene
	player.set_process_mode(player.PROCESS_MODE_DISABLED) #Disables the Player Scene
	player.hide() #Hides the Player scene
	battle_music.stop() #Stops the Battle music
	game_over_music.play() #Plays the Game over music
	await get_tree().create_timer(10).timeout #Lets the game wait until the Game Over music has finished playing
	game_over_music.stop() #Stops the Game over music
	#$UI.game_over.hide() #Hides the Game over Texture
	#$UI.start.show() #Shows the Start Button
	get_tree().reload_current_scene()


func _on_start_pressed():
	#start.hide() #Hides the Start Button
	#new_game() #Starts the New Game function
	pass

func _on_ui_new_game():
	new_game() #Starts the New Game function


func _on_server_boom():
	await get_tree().create_timer(5).timeout
	print ("Winning")
	$UI.winning()  #Shows the Conglaturations Texture
	spawner.set_process_mode(spawner.PROCESS_MODE_DISABLED) #Disables the Spawner Scene
	spawner.hide() #Hides the Spawner Scene
	player.set_process_mode(player.PROCESS_MODE_DISABLED) #Disables the Player Scene
	player.hide() #Hides the Player scene
	battle_music.stop() #Stops the Battle music
	winning_music.play()
	await get_tree().create_timer(41).timeout #Lets the game wait until the Game Over music has finished playing
	get_tree().reload_current_scene()



func _on_server_armed():
	battle_music.stop()
