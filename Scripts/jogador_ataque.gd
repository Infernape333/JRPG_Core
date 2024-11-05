extends CharacterBody2D

@export var sprite_campo: CharacterBody2D
@export var target: CharacterBody2D

@export var battle_scene: Node2D  # Referência à cena de campo de batalha


var attack_stamina_cost = {
	"ponteira": 20,
	"raboDeArraia": 30
}

func _ready():
	pass

func _physics_process(delta):
	if self.visible == false:
		$Collision_jogador.disabled = true
	else:
		$Collision_jogador.disabled = false

func _on_ponteira_pressed():
	if TurnManager.current_turn == TurnManager.Turn.PLAYER:
		iniciar_sequencia("ponteira")

func _on_rabo_de_arraia_pressed():
	if TurnManager.current_turn == TurnManager.Turn.PLAYER:
		iniciar_sequencia("raboDeArraia")

func iniciar_sequencia(ataque):
	var setas_scene = load("res://Cenas/fila_de_setas.tscn").instantiate()
	battle_scene.add_child(setas_scene)
	setas_scene.reset_sequence()
	
	await get_tree().create_timer(8).timeout
	
	if jogador_acertou_sequencia(setas_scene.acertos):
		await realizar_ataque(ataque)
	else:
		TurnManager.switch_turn()
	
	setas_scene.queue_free()

func jogador_acertou_sequencia(acertos: int) -> bool:
	return acertos >= 7

func realizar_ataque(ataque):
	if TurnManager.current_turn == TurnManager.Turn.PLAYER:
		self.visible = true
		sprite_campo.visible = false
		
		if ataque == "ponteira":
			$AnimatedSprite2D.play("Ponteira")
			await $AnimatedSprite2D.animation_finished
		elif ataque == "raboDeArraia":
			$AnimatedSprite2D.play("RaboDeArraia")
			await $AnimatedSprite2D.animation_finished
			
		sprite_campo.attack(target, attack_stamina_cost[ataque])
		sprite_campo.visible = true
		self.visible = false
		TurnManager.switch_turn()
