extends CharacterBody2D


var elemento = "fogo"

func _ready():
	$Butao.hide()

func _physics_process(delta):
	$AnimatedSprite2D.play("default")


func _on_area_2d_body_entered(body):
	$Butao.show()

func _on_area_2d_body_exited(body):
	$Butao.hide()
