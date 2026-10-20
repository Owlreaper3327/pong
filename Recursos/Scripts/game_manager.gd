extends Node

class_name GameManager;

@onready var puntuacion_p1: int = 0;
@onready var puntuacion_p2: int = 0;
@onready var marcador: Notificador = $HUD/Notificador
@onready var jugando = false
@onready var victoria: int = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/instruccion.visible = true
	#Aquí se cargarán los scripts para poner un jugador dos o la pc
	pass # Replace with function body.

func actualizar_puntuacion():
	
	var p1 = "Jugador 1: {punt}".format({"punt": puntuacion_p1})
	var p2 = "Jugador 2: {punt}".format({"punt": puntuacion_p2})
	
	$HUD/Puntuacion_p1.text = p1
	$HUD/Puntuacion_p2.text = p2

func score(izquierda:bool) -> void:
	if izquierda:
		puntuacion_p1 += 1;
	else:
		puntuacion_p2 +=1;
	
	actualizar_puntuacion()
	marcador.actualizar_marcador(puntuacion_p1, puntuacion_p2)
	
	#reiniciar la posición de la bola
	#Hay que poner un retraso
	jugando = false
	await get_tree().create_timer(2).timeout
	$HUD/instruccion.visible = true
	$Pelota.iniciar()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("pausar") and !jugando:
		$HUD/instruccion.visible = false
		await get_tree().create_timer(1).timeout
		$Pelota.lanzar()
		jugando = false
	
	pass


func _on_area_puntuacion_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	score(false)
	pass # Replace with function body.


func _on_area_puntuacion_2_body_entered(body: Node2D) -> void:
	score(true)
	pass # Replace with function body.
