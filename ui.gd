extends CanvasLayer

signal new_game

var score = 0

func _ready():
	$Health.value = 100
	$"Game Over".hide()
	$Start.show()

func _process(delta):
	pass

func game_done():
	$"Game Over".show()
	await get_tree().create_timer(10).timeout
	$"Game Over".hide()
	$Start.show()

func _on_start_pressed():
	$Start.hide()
	new_game.emit()


func _on_enemy_spawner_child_exiting_tree(node):
	score += 1
	$Score.text = str(score)
	if score == 69:
		$Noice.play()


func _on_character_health_lost():
	$Health.value -= 10
	
