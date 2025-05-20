extends AbstractEnemyState

func enter():
	character.velocity = Vector2.ZERO
	fire()
	
func fire():
	character._fire()
	character._play_animation("attack")
	
func update(delta: float):
	character._look_at_target()
	
func _on_animation_finished(anim_name: String):
	if character.target == null:
		finished.emit("idle")
		
	else:
		match anim_name:
			"attack":
				character._play_animation("alert")
			"alert":
				if character._can_see_target():
					fire()
				else:
					finished.emit("idle")
					
func _handle_body_exited(body):
	super._handle_body_exited(body)
	
	if character.target == null:
		if character.get_current_animation() != "attack":
			finished.emit("idle")
	
