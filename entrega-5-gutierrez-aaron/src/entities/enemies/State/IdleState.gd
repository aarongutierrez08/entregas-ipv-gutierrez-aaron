extends AbstractEnemyState

@onready var idle_timer: Timer = $IdleTimer

func enter() -> void:
	character.velocity = Vector2.ZERO
	
	if character.target != null:
		character._play_animation("idle_alert")
	else:
		character._play_animation("idle")
		
	idle_timer.start()
	
func exit():
	idle_timer.stop()
	
func update(delta: float) -> void:
	character._apply_movement()
	if character._can_see_target():
		finished.emit("alert")

func _on_idle_timer_timeout() -> void:
	finished.emit("walk")
			
func _handle_body_entered(body: Node):
	super._handle_body_entered(body)
	character._play_animation("alert")
		
func _handle_body_exited(body: Node):
	super._handle_body_exited(body)
	character._play_animation("go_normal")
