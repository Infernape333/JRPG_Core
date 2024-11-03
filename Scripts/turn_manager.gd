extends Node2D

enum Turn { PLAYER, ENEMY }


signal beat(position)
signal measure(position)

var damage_chart = {
	"fogo": {"forte_contra": "grama", "fraco_contra": "agua"},
	"agua": {"forte_contra": "fogo", "fraco_contra": "grama"},
	"grama": {"forte_contra": "agua", "fraco_contra": "fogo"}
}
var current_turn: Turn = Turn.PLAYER
signal turn_changed(new_turn)

func _ready():
	emit_signal("turn_changed", current_turn)

func switch_turn():
	if current_turn == Turn.PLAYER:
		current_turn = Turn.ENEMY
	else:
		current_turn = Turn.PLAYER
	emit_signal("turn_changed", current_turn)
