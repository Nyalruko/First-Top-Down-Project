extends CharacterBody2D

class_name Melee_Enemy

@export var SPEED = 100.0
@export var HEALTH = 10
@export var DAMAGE = 5

@onready var pathfinding = $NavigationAgent2D

#THIS IS A TEST

var player : Node2D

func _ready():
	call_deferred("targeting")

func targeting():
	await get_tree().physics_frame
	if player:
		pathfinding.target_position = player.global_position

func _physics_process(delta):
	if player:
		pathfinding.target_position = player.global_position
	if pathfinding.is_navigation_finished():
		return
	
	var personal_position = global_position
	var next_path_position = pathfinding.get_next_path_position()
	var direction = (player.global_position - global_position).normalized()
	#var direction = (next_path_position).normalized()
	look_at(global_position + direction) #Makes the Node rotate towards the direction of the player
	$AnimatedSprite2D.play()
	var var_velocity = personal_position.direction_to(next_path_position) * SPEED
	if pathfinding.avoidance_enabled:
		pathfinding.set_velocity(var_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(var_velocity)
	move_and_slide()

func _on_hitbox_area_entered(area):
	if area.get_parent() is Bullet:
		queue_free() #Deletes the node


func _on_painbox_area_entered(area):
	if area.get_parent() is Player:
		queue_free()


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	pass # Replace with function body.
