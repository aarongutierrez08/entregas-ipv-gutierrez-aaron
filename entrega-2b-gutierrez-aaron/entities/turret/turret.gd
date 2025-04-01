extends Sprite2D

@export var projectile_scene: PackedScene
@onready var fire_position: Marker2D = $FirePosition

var player
var projectile_container: Node

func set_player(player, projectile_container):
	self.player = player
	self.projectile_container = projectile_container
	$Timer.start()
	
func _on_timer_timeout() -> void:
	fire()
	
func fire():
	var projectile_instance: Projectile = projectile_scene.instantiate()
	projectile_container.add_child(projectile_instance)
	projectile_instance.set_starting_values(fire_position.global_position, (player.global_position - fire_position.global_position).normalized())
	projectile_instance.delete_requested.connect(on_projectile_delete_request)
	
func on_projectile_delete_request(projectile: Projectile):
	projectile_container.remove_child(projectile)
	projectile.queue_free()
