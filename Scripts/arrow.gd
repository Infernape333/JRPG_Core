extends Node2D


@export var arrow_type : String
@export var speed = 200  
@export var direction = Vector2(0, -1)
var hit_zone_position = 65
var hit_tolerance = 20

# Sinal que será emitido quando uma seta for acertada
signal seta_acertada

func _process(delta):
	position += direction * speed * delta

	# Verifica se a seta está na zona de acerto
	if abs(position.y - hit_zone_position) < hit_tolerance:
		check_input()
	if abs(position.y - hit_zone_position) > hit_tolerance:
		check_input_erro()

	# Remove a seta quando sair da tela
	if position.y < 0:
		queue_free()

func check_input():
	# Verifica se o jogador pressionou a tecla correta para o tipo de seta
	if arrow_type == "up" and Input.is_action_just_pressed("ui_up"):
		emit_signal("seta_acertada")  # Emite o sinal de acerto
		queue_free()
	elif arrow_type == "down" and Input.is_action_just_pressed("ui_down"):
		emit_signal("seta_acertada")  # Emite o sinal de acerto
		queue_free()
	elif arrow_type == "left" and Input.is_action_just_pressed("ui_left"):
		emit_signal("seta_acertada")  # Emite o sinal de acerto
		queue_free()
	elif arrow_type == "right" and Input.is_action_just_pressed("ui_right"):
		emit_signal("seta_acertada")  # Emite o sinal de acerto
		queue_free()

func check_input_erro():
	# Verifica se o jogador pressionou a tecla correta para o tipo de seta
	if arrow_type == "up" and Input.is_action_just_pressed("hit_up"):
		queue_free()
	elif arrow_type == "down" and Input.is_action_just_pressed("hit_down"):
		queue_free()
	elif arrow_type == "left" and Input.is_action_just_pressed("hit_left"):
		queue_free()
	elif arrow_type == "right" and Input.is_action_just_pressed("hit_right"):
		queue_free()
