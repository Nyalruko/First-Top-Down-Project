extends CharacterBody2D

@onready var ContraGuyTopDown = $AnimatedSprite2D

var bullet_scene = preload("res://bullet.tscn")

var direction : Vector2 = Vector2 (0,0)
var movement_speed : int = 300
var can_shoot = true

signal Died 

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if Input.is_action_pressed("Fire"): #Checks Shooting Input
		if can_shoot: #Checks if a bullet can be fired
			can_shoot = false #Disallows firing a bullet
			$"Weapon Cooldown".start() #Starts timer to fire bullet again
			bang_sound() #Plays shooting Sound effect
			shoot_bullet() #Fires Bullet
	move_character()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func move_character():
	var move_x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	var move_y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	direction = Vector2(move_x, move_y)
	look_at(global_position + direction) #Makes the Node rotate towards the direction of the input
	velocity = direction.normalized() * movement_speed
	if move_x or move_y !=0: #Plays the walking animation or idle
		ContraGuyTopDown.play("walk")
	else:
		ContraGuyTopDown.play("idle")
	if Input.is_action_pressed("Move Backwards"):
		look_at(global_position - direction)
		velocity *= 0.7
	move_and_slide()

func shoot_bullet():
	var bullet = bullet_scene.instantiate() #Creates Instance of a bullet
	bullet.dir = rotation #Tells bullet the direction of the barrel
	bullet.pos = $Barrel.global_position #Tells the bullet where to spawn
	bullet.rota = global_rotation #Tells the bullet how to be rotated
	get_parent().add_child(bullet) #Spawns instance of a bullet

func _on_hitbox_body_entered(body):
	emit_signal("Died") #Tells the main node to end the game

func bang_sound(from_position = 0.0):
	randomize()
	$Bang.pitch_scale = randf_range(0.9, 1.1)
	$Bang.play(from_position)

func _on_weapon_cooldown_timeout():
	can_shoot = true #Allows to fire a bullet again
