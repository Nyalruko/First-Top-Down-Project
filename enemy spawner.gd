extends Node2D

@export var enemy_instance : PackedScene
@export var enemy_instance2 : PackedScene
@export var enemy_instance3 : PackedScene
@export var target : Node2D



func _on_timer_timeout():
	var enemy = enemy_instance.instantiate() #Creates an instance of the enemy scene
	var enemy2 = enemy_instance2.instantiate() #Creates an instance of the enemy2 scene
	var enemy3 = enemy_instance3.instantiate()
	var Sprite_Roulette : int = randi_range (0,2) #Creates an integer of either 0 or 1
	if Sprite_Roulette == 0 : #If the integer is 0 it spawns the enemy scene
		enemy.player = target #Lets the enemy scene see the player as a target to move towards
		add_child(enemy) #Spawns an enemy scene
	elif Sprite_Roulette == 1 : #If the integer is 0 it spawns the enemy scene
		enemy3.player = target #Lets the enemy scene see the player as a target to move towards
		add_child(enemy3)
	else: #If the integer is not 0 it spawns the enemy 2 scene
		enemy2.player = target #Lets the enemy 2 scene see the player as a target to move towards
		add_child(enemy2) #Spawns an enemy 2 scene
