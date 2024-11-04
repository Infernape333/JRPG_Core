extends Node2D


@export var spawn_y = 250
@export var spawn_x_positions = [254, 321, 388, 455]
@export var base_arrow_speed = 100  # Base speed
@export var bpm = 65  # BPM da música
@export var max_arrows = 8  # Número máximo de setas por sequência
@export var target_y_position = 50  # Posição onde a seta deve ser clicada
@export var music_player: AudioStreamPlayer  # Referência ao player de música


var arrow_count = 0  # Contador de setas geradas
var spawn_interval = 60.0 / bpm  # Intervalo entre as setas, baseado no BPM
var spawn_timer = 0.0
var arrow_speed = base_arrow_speed

var acertos = 0  # Contagem de acertos do jogador

var arrow_types = [
"res://Cenas/arrowCima.tscn", 
"res://Cenas/arrowBaixo.tscn", 
"res://Cenas/arrowEsquerda.tscn",
"res://Cenas/arrowDireita.tscn"]

func _ready():
	$AudioStreamPlayer.play()

func _process(delta):
	if arrow_count < max_arrows:
		spawn_timer -= delta
		if spawn_timer <= 0:
			spawn_arrow()
			spawn_timer = spawn_interval

func spawn_arrow():
	# Escolhe aleatoriamente uma seta
	var arrow_scene = arrow_types[randi() % arrow_types.size()]
	var arrow_instance = load(arrow_scene).instantiate()

	# Adiciona a seta como filha da cena
	add_child(arrow_instance)
	
	if arrow_scene == "res://Cenas/arrowEsquerda.tscn":
		arrow_instance.position = Vector2(spawn_x_positions[0], spawn_y)
	elif arrow_scene == "res://Cenas/arrowCima.tscn":
		arrow_instance.position = Vector2(spawn_x_positions[1], spawn_y)
	elif arrow_scene == "res://Cenas/arrowDireita.tscn":
		arrow_instance.position = Vector2(spawn_x_positions[2], spawn_y)
	else:
		arrow_instance.position = Vector2(spawn_x_positions[3], spawn_y)
	
	var distance_to_travel = spawn_y - target_y_position
	var travel_time = spawn_interval
	arrow_instance.speed = distance_to_travel / travel_time
	# Conecta o sinal de acerto da seta para incrementar a contagem usando Callable
	arrow_instance.connect("seta_acertada", Callable(self, "_on_seta_acertada"))
	arrow_count += 1

# Função chamada quando uma seta é acertada
func _on_seta_acertada():
	acertos += 1

func reset_sequence():
	arrow_count = 0
	spawn_timer = 0
	acertos = 0
