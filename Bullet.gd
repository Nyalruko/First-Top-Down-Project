extends CharacterBody2D

var pos : Vector2
var rota : float
var dir : float
var speed = 500

func _ready():
	global_position = pos #Sets position of the bullet
	global_rotation = rota #Sets roation of the bullet

func _physics_process(delta):
	velocity = Vector2(speed, 0).rotated(dir) #Moves the bullet
	move_and_slide()

func _on_hitbox_area_entered(area):
	queue_free() #Deletes Bullet
