extends Node

func _ready() -> void:
	$Player.set_projectile_container(self)
	$Turret.set_player($Player, self)
