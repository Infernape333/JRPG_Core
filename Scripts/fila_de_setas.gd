extends Node2D


@export var spawn_y = 250
@export var spawn_x_positions = [254, 321, 388, 455]
@export var arrow_speed = 100
@export var spawn_interval = .8 
@export var max_arrows = 8  # Número máximo de setas por sequência

# AudioStreamPlayer para a música
#@export var audio_player: AudioStreamPlayer  
#@export var music_file: AudioStream  # Arquivo de música para sincronizar
#var beat_times = [1.0, 2.0, 3.0, 4.0, 5.0, 6.5, 8.0, 9.5]  # Tempos de beat para cada seta (em segundos)
#var current_beat_index = 0

var arrow_count = 0  # Contador de setas geradas
var spawn_timer = 0.0

var acertos = 0  # Contagem de acertos do jogador

var arrow_types = [
"res://Cenas/arrowCima.tscn", 
"res://Cenas/arrowBaixo.tscn", 
"res://Cenas/arrowEsquerda.tscn",
"res://Cenas/arrowDireita.tscn"]

func _ready():
	pass
	# Iniciar a música
	#audio_player.stream = music_file
	#audio_player.play()

func _process(delta):
	# Tempo atual da música
	#var music_time = audio_player.get_playback_position()
	
	# Gera setas no momento certo baseado nos tempos mapeados
	#if current_beat_index < beat_times.size() and music_time >= beat_times[current_beat_index]:
		#if arrow_count < max_arrows:
			#spawn_arrow()  # Gera uma nova seta
			#current_beat_index += 1  # Passa para o próximo beat
	
	# Contagem para spawnar novas setas
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
	
	#var random_x = spawn_x_positions[randi() % spawn_x_positions.size()]
	#arrow_instance.position = Vector2(random_x, spawn_y)
	
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
	#current_beat_index = 0
