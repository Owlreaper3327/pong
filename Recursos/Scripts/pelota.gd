extends RigidBody2D

const BALL_SPEED: int = 350

var rebotes: int

func iniciar():
	position = Vector2(0,0)
	
	linear_velocity = Vector2(0,0)
	
func lanzar():
	var direccion_x = 1.0 if randf() > 0.5 else -1.0
	var direccion_y = randf_range(-0.5, 0.5) #Hace que la pelota pueda ir en diagonal

	linear_velocity = Vector2(direccion_x, direccion_y).normalized() * BALL_SPEED #Pone la bola en juego


func acelerar():
	linear_velocity *= 1.05

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	iniciar()
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	
	var colision: KinematicCollision2D = move_and_collide(linear_velocity * delta)
	
	if colision:
		linear_velocity = linear_velocity.bounce(colision.get_normal())
		
	if colision != null:
		if is_instance_of(colision.get_collider(), Jugador):
			acelerar()
