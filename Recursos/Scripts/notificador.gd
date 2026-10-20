extends Control

class_name Notificador

var puntuacion_p1: int
var puntuacion_p2: int
@onready var marcador: Label = $HBoxContainer/puntuacion
@onready var anim = $animador


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	puntuacion_p1 = 0
	puntuacion_p2 = 0
	marcador.text = "{0} - {1}".format([puntuacion_p1, puntuacion_p2])
	visible = false
	pass # Replace with function body.

func actualizar_marcador(p1: int, p2: int) -> void:
	puntuacion_p1 = p1
	puntuacion_p2 = p2
	
	marcador.text = "{0} - {1}".format([puntuacion_p1, puntuacion_p2])
	anim.play("actualizar_puntuacion")
