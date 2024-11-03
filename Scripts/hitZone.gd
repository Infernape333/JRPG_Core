extends Node2D


func _ready():
	pass

func _process(delta):
	if sequencia_ativa():
		self.visible = true
	else:
		self.visible = false

func sequencia_ativa() -> bool:
	var battle_scene = get_parent()
	var setas_scene = battle_scene.get_node_or_null("fila_de_setas")
	return setas_scene != null
