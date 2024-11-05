extends CharacterBody2D


@export var player_hp: int = 100
@export var attack_power: int = 20
@export var player_stamina: int = 100
@export var max_stamina: int = 100  # Capacidade máxima de Stamina

@onready var barra_vida = $Healthbar
@onready var barra_stamina = $Staminabar
var current_health: int = player_hp
var current_stamina: int = max_stamina  # Inicializa a Stamina atual

func _ready():
	$Animated_jogador.play("idle")
	# Define a vida inicial na barra
	barra_vida.max_value = player_hp
	barra_vida.value = current_health
	barra_stamina.max_value = max_stamina
	barra_stamina.value = current_stamina
	TurnManager.connect("turn_changed", Callable(self, "_on_turn_changed"))

func attack(target, stamina_cost: int):
	if TurnManager.current_turn == TurnManager.Turn.PLAYER:
		if current_stamina >= stamina_cost:
			print("\nJogador atacou!")
			target.take_damage(attack_power)
			current_stamina -= stamina_cost
			update_stamina_bar()
		else:
			print("Stamina insuficiente")
			TurnManager.Turn.ENEMY

func take_damage(damage: int):
	current_health -= damage
	if current_health < 0:
		current_health = 0
	update_health_bar()
	
	player_hp -= damage
	print("Jogador tomou dano:", damage, " - HP restante:", player_hp)
	if player_hp <= 0:
		print("Jogador foi derrotado!")
		game_over()

# Função para curar o jogador
func heal(amount: int):
	current_health += amount
	if current_health > player_hp:
		current_health = player_hp
	update_health_bar()
	
	player_hp += amount
	print("Jogador se curou:", amount, "pontos - HP:", player_hp)
	if player_hp >= 100:
		player_hp = 100

func game_over():
	print("Fim do jogo! O jogador perdeu.")
	get_tree().change_scene_to_file("res://Cenas/mundo.tscn")

func _process(delta):
	pass

func _on_turn_changed(new_turn):
	if new_turn == TurnManager.Turn.PLAYER:
		print("Turno do jogador!")
		recover_stamina()

func recover_stamina():
	current_stamina += max_stamina * 0.1
	if current_stamina > max_stamina:
		current_stamina = max_stamina
	update_stamina_bar()
#indentificar dano para iniciar animação
func _on_area_dano_area_entered(area):
	$Animated_jogador.stop()
	$Animated_jogador.play("dano")
	await $Animated_jogador.animation_finished
	$Animated_jogador.play("idle")

func update_health_bar():
	barra_vida.value = current_health

func update_stamina_bar():
	barra_stamina.value = current_stamina
