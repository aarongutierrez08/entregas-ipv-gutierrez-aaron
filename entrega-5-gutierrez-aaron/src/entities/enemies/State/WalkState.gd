extends AbstractEnemyState

@export var wander_radius: Vector2
@export var speed: float
@export var max_speed: float
@export var pathfinding_step_threshold: float = 5.0

var path: Array = []

func enter():
	if character.pathfinding != null:
		var random_point: Vector2 = Vector2(
			randf_range(-wander_radius.x, wander_radius.x),
			randf_range(-wander_radius.y, wander_radius.y)
		)
		
		path = character.pathfinding.get_simple_path(
			character.global_position,
			random_point
		)
		
		if path.is_empty() || path.size() == 1:
			finished.emit("idle")
		else:
			if character.target != null:
				character._play_animation("walk_alert")
			else:
				character._play_animation("walk")
	else:
		finished.emit("idle")

func exit():
	path = []
	
func update(delta: float):
	if character._can_see_target():
		finished.emit("alert")
		
	if path.is_empty():
		finished.emit("idle")
		return
	
	var next_point = path.front()
	while character.global_position.distante_to(next_point) < pathfinding_step_threshold:
		path.pop_front()
		
		if path.is_empty():
			finished.emit("idle")
			return
			
	next_point = path.front()
	
	character.velocity = (
		character.velocity +
		character.global_position.direction_to(next_point) * speed
	).clamped(max_speed)
	character._apply_movement()
	character.body_anim.flip.h = character.velocity.x < 0
		
