extends CharacterBody2D



@onready var timer = $Timer

@export var intervalo = 2.5
@export var Enemy_name = "Worm"
@export var level: int = 1
@export var hp: int = 50
@export var dano: int = 10

var velocidade = 30
var direcao = Vector2.RIGHT
var current_hp = hp

func _ready():
	timer.wait_time = intervalo
	add_child(timer)
	timer.start()
	$LesseAnimation.play("Walking")

func _on_timer_timeout():
	alterar_direcao()

func alterar_direcao():
	velocidade = 0
	await get_tree().create_timer(1).timeout 
	velocidade = 30
	if direcao == Vector2.RIGHT:
		direcao = Vector2.LEFT
		$LesseAnimation.flip_h = true
	else:
		direcao = Vector2.RIGHT
		$LesseAnimation.flip_h = false

func _physics_process(delta):
	velocity = direcao * velocidade
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		print("aaa")
		start_battle()
	

func start_battle():
	VariaveisGlobais.battle_enemy_data = {
	"name": "Enemy_name",
	"level": level,
	"hp": hp,
	"dano": dano
}
	get_tree().change_scene_to_file("res://lesser_battle.tscn")


