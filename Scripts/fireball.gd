extends Node2D


var speed := 500
var velocity := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("fireball")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += speed * delta * -1


func _on_area_2d_body_entered(body):
	if body.get_name() == "jogador_campo":
		print("heliogay")
		$AnimatedSprite2D.play("destroy")
		speed = 0
		await get_tree().create_timer(1.2).timeout
		queue_free()
