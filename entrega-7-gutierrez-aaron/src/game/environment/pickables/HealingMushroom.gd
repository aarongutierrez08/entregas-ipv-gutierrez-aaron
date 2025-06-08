extends Node2D

onready var mushroom_body: Sprite = $MushroomBody
onready var pickup_particles: Particles2D = $PickupParticles

export (int) var heal_amount: int = 3.0
export (int) var chance_frames: int = 36

var _picked: bool = false


func _ready() -> void:
	mushroom_body.frame = randi() % chance_frames


func _on_PickArea_body_entered(body: Node) -> void:
	if body.has_method("notify_heal") && !_picked:
		_picked = true
		body.notify_heal(heal_amount)
		pickup_particles.emitting = true
		mushroom_body.hide()
		yield(get_tree().create_timer(pickup_particles.lifetime), "timeout")
		call_deferred("_remove")


func _remove() -> void:
	get_parent().remove_child(self)
	queue_free()
