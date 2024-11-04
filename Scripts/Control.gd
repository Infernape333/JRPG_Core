extends Control


@onready var btn1 = $ponteira
@onready var btn2 = $raboDeArraia

func _ready():
	pass

func _process(delta):
	if TurnManager.current_turn == TurnManager.Turn.PLAYER and !sequencia_ativa():
		self.visible = true
	else:
		self.visible = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_left"):
		btn1.grab_focus()
	elif event.is_action_pressed("ui_right"):
		btn2.grab_focus()


func sequencia_ativa() -> bool:
	var battle_scene = get_parent()
	var setas_scene = battle_scene.get_node_or_null("fila_de_setas")
	return setas_scene != null
