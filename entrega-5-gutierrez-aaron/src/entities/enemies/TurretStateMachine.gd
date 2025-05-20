extends AbstractStateMachine


func _on_detection_area_body_entered(body: Node2D) -> void:
	current_state.handle_event("body_entered", body)


func _on_detection_area_body_exited(body: Node2D) -> void:
	current_state.handle_event("body_exited", body)


func _on_body_animation_finished() -> void:
	_on_animation_finished(character.get_current_animation())


func _on_turret_hit(amount: int) -> void:
	if current_state != $Dead:
		_change_state("dead")
