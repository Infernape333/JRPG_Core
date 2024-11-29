extends Node2D

@onready var enemy_position = $EnemyPosition
@onready var player_position = $PlayerPosition

# Referências ao inimigo e jogador
var enemy_data
var player_data

# Configura os elementos na batalha
func setup_battle(enemy_info, player_info):
	# Recebe os dados
	enemy_data = enemy_info
	player_data = player_info
	
	# Instancia o inimigo e o jogador nas posições
	var enemy_instance = enemy_info.scene.instance()
	var player_instance = player_info.scene.instance()
	
	enemy_instance.position = enemy_position.global_position
	player_instance.position = player_position.global_position
	
	add_child(enemy_instance)
	add_child(player_instance)
