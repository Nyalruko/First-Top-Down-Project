extends CharacterBody2D

const SPEED = 100.0
var player : Node2D
signal Killed


func _physics_process(delta):
	var direction = (player.global_position - global_position).normalized()
	look_at(player.global_position) #Makes the Node rotate towards the direction of the player
	velocity = direction * SPEED
	move_and_slide()

func _on_hitbox_area_entered(area):
	if area.get_parent() is Bullet:
		emit_signal("Killed") #Tells script that it died
		queue_free() #Deletes the node
