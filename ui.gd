extends CanvasLayer

signal new_game

var score = 0

func _ready():
	$Health.value = 100
	$Conglaturations.hide()
	$"Game Over".hide()
	$Start.show()
	$Health.hide()

func _process(delta):
	pass

func game_done():
	$"Game Over".show()
	await get_tree().create_timer(10).timeout
	$"Game Over".hide()
	$Start.show()

func _on_start_pressed():
	$Start.hide()
	$Health.show()
	new_game.emit()


func _on_enemy_spawner_child_exiting_tree(node):
	score += 1
	$Score.text = str(score)
	if score == 69:
		$Noice.play()


func _on_character_health_lost():
	$Health.value -= 10
	
	
func winning():
	$"Conglaturations".show()
	$Health.hide()
	await get_tree().create_timer(41).timeout
	$"Conglaturations".hide()
	$Start.show()
