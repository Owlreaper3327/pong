extends Node

class_name GameManager;

@onready var puntuacion_p1: int = 0;
@onready var puntuacion_p2: int = 0;
@onready var marcador: Notificador = $HUD/Notificador;
@onready var jugando = false;
@onready var victoria: int = 1;
@onready var pausado: bool = false;
@onready var terminado = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/instruccion.visible = true
	set_physics_process(false);
	#Aquí se cargarán los scripts para poner un jugador dos o la pc
	pass # Replace with function body.

func actualizar_puntuacion():
	
	var p1 = "Jugador 1: {punt}".format({"punt": puntuacion_p1})
	var p2 = "Jugador 2: {punt}".format({"punt": puntuacion_p2})
	
	$HUD/Puntuacion_p1.text = p1
	$HUD/Puntuacion_p2.text = p2

func procesar_ganador() -> void:
	
	var p1_ganador: bool = puntuacion_p1 == 15;
	
	var texto_ganador: String = "Gana el jugador 1" if p1_ganador else "Gana el jugador 2";
	$HUD/mensaje_ganador.text = texto_ganador;
	$HUD/animador.play("mostrar_ganador");
	terminado = true;
	pausar();
	

func score(izquierda:bool) -> void:
	if izquierda:
		puntuacion_p1 += 1;
	else:
		puntuacion_p2 +=1;
	
	var ganador: bool = puntuacion_p1 == victoria or puntuacion_p2 == victoria;
	actualizar_puntuacion()
	marcador.actualizar_marcador(puntuacion_p1, puntuacion_p2)
	
	#reiniciar la posición de la bola
	#Hay que poner un retraso
	jugando = false
	await get_tree().create_timer(2).timeout
	
	if ganador:
		self.procesar_ganador();
		pausar();
		return;
	
	$HUD/instruccion.visible = true
	$Pelota.iniciar()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("pausar") and !jugando:
		$HUD/instruccion.visible = false
		await get_tree().create_timer(1).timeout
		$Pelota.lanzar()
		jugando = false
	
	if Input.is_action_just_pressed("pausa"):
		pausar();
	pass

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("pausa"):
		reanudar();

func pausar() -> void:
	
	if !pausado:
		
		get_tree().paused = true;
		
		for i in self.get_children():
			i.set_process(false);
			i.set_physics_process(false);
		
		$HUD/instruccion.visible = false;
		marcador.visible = false;
		pausado = true;
		set_process(false);
		set_physics_process(true);

func reanudar() -> void:
	
	if pausado and !terminado:
		
		get_tree().paused = false;
		
		for i in self.get_children():
			i.set_process(true);
			i.set_physics_process(true);
		
		set_process(true)
		set_physics_process(false)
		pausado = false;

func _on_area_puntuacion_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	score(false)
	pass # Replace with function body.


func _on_area_puntuacion_2_body_entered(body: Node2D) -> void:
	score(true)
	pass # Replace with function body.
