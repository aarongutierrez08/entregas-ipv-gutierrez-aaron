extends AbstractState


func enter() -> void:
	character.snap_vector = Vector2.ZERO
	character.velocity.y -= character.jump_speed
	character._play_animation("jump")

func update(delta: float) -> void:
	character._handle_weapon_actions()
	character._handle_move_input()
	if character.move_direction == 0:
		character._handle_deacceleration()
	character._apply_movement()
	if character._is_on_floor():
		if character.move_direction == 0:
			finished.emit("idle")
		else:
			finished.emit("walk")
	else:
		if character.velocity.y > 0:
			character._play_animation("fall")
		else:
			character._play_animation("walkd")
			
func handle_event(event: String, value = null) -> void:
	match event:
		"hit":
			character._handle_hit(value)
			if character.dead:
				emit_signal("finished", "dead")
