extends Jugador

@onready var pelota = $"../Pelota"

func _physics_process(delta: float) -> void:
	
	velocity.y = get_direction() * SPEED
	velocity.x = 0
	
	move_and_collide(velocity * delta)


func get_direction() -> int:
	
	if (pelota.position.y - position.y > 0):
		return 1
	elif (pelota.position.y - position.y == 0):
		return 0
	else:
		return -1
