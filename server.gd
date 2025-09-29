extends StaticBody2D

@onready var interaction_area: Interaction_Area = $"Interaction Area"

signal Boom
signal Armed

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "arm_server")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func arm_server():
	emit_signal("Armed")
	$Arming.play()
	await get_tree().create_timer(20).timeout
	$Arming.stop()
	emit_signal("Boom")
	$Explosion.play()
