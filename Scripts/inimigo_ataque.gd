extends CharacterBody2D

@export var sprite_campo: CharacterBody2D
@export var target: CharacterBody2D

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

func _ready():
	opcoes_de_ataque_aleatorio = gerar_ataques_aleatorios()

func _physics_process(delta):
	if TurnManager.current_turn == TurnManager.Turn.ENEMY and not is_attacking:
		is_attacking = true
		enemy_attack()

func enemy_attack():
	await get_tree().create_timer(3).timeout
	for i in range(opcoes_de_ataque_aleatorio.size()):
		ataque(opcoes_de_ataque_aleatorio[i])
		opcoes_de_ataque_aleatorio.remove_at(i)
		break

func ataque(ataque):
	self.visible = true
	sprite_campo.visible = false
	
	if ataque == "fogo":
		$AnimationPlayer.play("ataque")
		await $AnimationPlayer.animation_finished
		print(self.visible)
		fire_ball()
		
	sprite_campo.visible = true
	self.visible = false
	await get_tree().create_timer(2).timeout
	
	if !ataque == "nulo":
		sprite_campo.attack(target)
	
	await  get_tree().create_timer(2).timeout
	
	is_attacking = false
	TurnManager.switch_turn()



const BolaDeFogo = preload("res://Cenas/fireball.tscn")
func fire_ball():
	var bola_de_fogo_instance = BolaDeFogo.instantiate()
	get_parent().add_child(bola_de_fogo_instance)
	bola_de_fogo_instance.position = Vector2(714, 347)
