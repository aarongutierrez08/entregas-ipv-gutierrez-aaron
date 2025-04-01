extends Sprite2D

var speed: float = 50

func _process(delta: float) -> void:
	var direction = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	position.x += direction * speed * delta
