extends CanvasLayer

signal new_game

var score = 0

func _ready():
	$"Game Over".hide()
	$Start.show()

func _process(delta):
	pass

func score_increase():
	score += 1
	$Score.text = str(score)

func game_done():
	$"Game Over".show()
	await get_tree().create_timer(10).timeout
	$"Game Over".hide()
	$Start.show()

func _on_start_pressed():
	$Start.hide()
	new_game.emit()
