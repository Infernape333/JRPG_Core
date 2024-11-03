extends CharacterBody2D


@export var enemy_hp: int = 100
@export var attack_power: int = 20

@onready var barra_vida = $ProgressBar
var current_health: int = enemy_hp

func _ready():
	$Animated_inimigo.play("idle")
	# Define a vida inicial na barra
	barra_vida.max_value = enemy_hp
	barra_vida.value = current_health
	TurnManager.connect("turn_changed", Callable(self, "_on_turn_changed"))

func attack(target):
	if TurnManager.current_turn == TurnManager.Turn.ENEMY:
		print("\nInimigo atacou!")
		target.take_damage(attack_power)

func take_damage(damage: int):
	current_health -= damage
	if current_health < 0:
		current_health = 0  # Garante que a vida não fique negativa
	barra_vida.value = current_health  # Atualiza a barra de vida
	
	enemy_hp -= damage
	print("Inimigo tomou dano:", damage, " - HP restante:", enemy_hp)
	if enemy_hp <= 0:
		print("Inimigo foi derrotado!")
		game_over()

# Função para curar o jogador
func heal(amount: int):
	current_health += amount
	if current_health > enemy_hp:
		current_health = enemy_hp  # Garante que a vida não exceda o máximo
	barra_vida.value = current_health  # Atualiza a barra de vida
	
	enemy_hp += amount
	print("Inimigo se curou:", amount, "pontos - HP:", enemy_hp)
	if enemy_hp >= 100:
		enemy_hp = 100

func game_over():
	print("Fim do jogo! O Inimigo perdeu.")
	$Animated_inimigo.stop()
	$Animated_inimigo.play("morte")
	await $Animated_inimigo.animation_finished
	get_tree().change_scene_to_file("res://Cenas/mundo.tscn")

func _process(delta):
	pass

func _on_turn_changed(new_turn):
	if new_turn == TurnManager.Turn.ENEMY:
		print("Turno do inimigo!")


func _on_area_2d_body_entered(body):
	$Animated_inimigo.play("dano")
	await $Animated_inimigo.animation_finished
	$Animated_inimigo.play("idle")
