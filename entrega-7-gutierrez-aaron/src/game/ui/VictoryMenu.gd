extends Control

## Menú de victoria genérico. Solo se presenta si se levanta la signal
## de "level_won" en GameState.

signal next_selected()
signal return_selected()


func _ready() -> void:
	hide()
	GameState.connect("level_won", self, "_on_level_won")


func _on_level_won() -> void:
	show()


func _on_NextButton_pressed() -> void:
	hide()
	emit_signal("next_selected")


func _on_ReturnButton_pressed() -> void:
	hide()
	emit_signal("return_selected")


func show() -> void:
	.show()
	get_tree().paused = true


func hide() -> void:
	.hide()
	get_tree().paused = false
