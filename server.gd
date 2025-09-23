extends StaticBody2D

signal Boom
signal Armed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Test Button"):
		arm_server()

func arm_server():
	emit_signal("Armed")
	$Arming.play()
	await get_tree().create_timer(20).timeout
	$Arming.stop()
	emit_signal("Boom")
	$Explosion.play()

func _on_interactive_area_body_entered(body):
	pass
	#if body.get_parent() is Player and Input.is_action_pressed("Interact"):
		#arm_server()
