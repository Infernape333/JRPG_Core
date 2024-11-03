extends CharacterBody2D

var SPEED = 50.0
var direction = "south"
var original_speed = SPEED
var dialogue_active = false  

func _physics_process(delta):
	if not dialogue_active: 
		_move()
		_update_animation()
		move_and_slide()

func _move():
	var direction: Vector2 = Vector2(Input.get_axis("Esquerda", "Direita"), Input.get_axis("Cima", "Baixo"))
	if direction:
		velocity = direction.normalized() * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

func _update_animation():
	if velocity.length() > 0:
		if velocity.x > 0:
			$Anime.play("Andando_Direita")
			direction = "east"
		elif velocity.x < 0:
			$Anime.play("Andando_Esquerda")
			$Anime.flip_h = true
			direction = "west"
		elif velocity.y > 0:
			$Anime.play("Andando_Baixo")
			direction = "south"
		elif velocity.y < 0:
			$Anime.play("Andando_Cima")
			direction = "north"
	else:
		if direction == "east":
			$Anime.play("Parado_Direita")
		elif direction == "west":
			$Anime.play("Parado_Esquerda")
		elif direction == "south":
			$Anime.play("Parado_Baixo")
		else:
			$Anime.play("Parado_Cima")

func set_dialogue_active(active: bool):
	dialogue_active = active
	if active: 
		SPEED = 0
	else:
		SPEED = original_speed
