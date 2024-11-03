extends Control


@onready var painel = $".."
@onready var btn1 = $ataque
@onready var btn2 = $ataque2

# Called when the node enters the scene tree for the first time.
func _ready():
	#btn.grab_focus()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if TurnManager.current_turn == TurnManager.Turn.PLAYER:
		painel.visible = true
	else:
		painel.visible = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_left"):  # Por exemplo, seta para a esquerda
		btn2.grab_focus()  # Mude o foco para outro botão
	elif event.is_action_pressed("ui_right"):  # Por exemplo, seta para a direita
		btn1.grab_focus()
