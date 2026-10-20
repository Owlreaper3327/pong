extends CharacterBody2D

class_name Jugador;

const SPEED = 400.0
var posicion_inicial: float

func reinicio():
	
	position.y = 0

func _ready() -> void:
	posicion_inicial = position.x

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("subir", "bajar")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = direction * SPEED
	
	move_and_collide(Vector2(0, velocity.y * delta))
	
	if position.x != posicion_inicial:
		position.x = posicion_inicial
