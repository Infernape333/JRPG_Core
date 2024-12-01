extends CharacterBody2D


@export var target: CharacterBody2D

@export var enemy_hp: int = 100
@export var attack_power: int = 20

#@onready var barra_vida = $ProgressBar
var current_health: int = enemy_hp

func _ready():
	opcoes_de_ataque_aleatorio = gerar_ataques_aleatorios()
	
	$Animated_inimigo.play("idle")
	# Define a vida inicial na barra
	#barra_vida.max_value = enemy_hp
	#barra_vida.value = current_health
	TurnManager.connect("turn_changed", Callable(self, "_on_turn_changed"))
	
func _physics_process(delta):
	if TurnManager.current_turn == TurnManager.Turn.ENEMY and not is_attacking:
		is_attacking = true
		enemy_attack()

func attack(target):
	if TurnManager.current_turn == TurnManager.Turn.ENEMY:
		print("\nInimigo atacou!")
		target.take_damage(attack_power)

func take_damage(damage: int):
	current_health -= damage
	if current_health < 0:
		current_health = 0  # Garante que a vida não fique negativa
	#barra_vida.value = current_health  # Atualiza a barra de vida
	
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
	#barra_vida.value = current_health  # Atualiza a barra de vida
	
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
	await get_tree().create_timer(.5).timeout
	$Animated_inimigo.play("dano")
	await $Animated_inimigo.animation_finished
	$Animated_inimigo.play("idle")


var opcoes_de_ataque_aleatorio : Array = []

var is_attacking = false

func gerar_ataques_aleatorios():
	var opcoes_de_ataque = ["fogo"]
	var ataques_aleatorios = []
	var numero_de_ataques = 8
	randomize()
	
	for i in range(numero_de_ataques):
		var ataque = opcoes_de_ataque[randi() % opcoes_de_ataque.size()]
		ataques_aleatorios.append(ataque)
		
	return ataques_aleatorios

func enemy_attack():
	await get_tree().create_timer(3).timeout
	for i in range(opcoes_de_ataque_aleatorio.size()):
		ataque(opcoes_de_ataque_aleatorio[i])
		opcoes_de_ataque_aleatorio.remove_at(i)
		break

func ataque(ataque):
	if ataque == "fogo":
		$AnimationPlayer.play("ataque")
		await $AnimationPlayer.animation_finished
		print(self.visible)
		fire_ball()
		
	await get_tree().create_timer(2).timeout
	
	if !ataque == "nulo":
		pass
	
	await get_tree().create_timer(2).timeout
	
	is_attacking = false
	TurnManager.switch_turn()

const BolaDeFogo = preload("res://Cenas/fireball.tscn")
func fire_ball():
	var bola_de_fogo_instance = BolaDeFogo.instantiate()
	get_parent().add_child(bola_de_fogo_instance)
	bola_de_fogo_instance.position = Vector2(714, 347)

