extends Node2D

export (PoolStringArray) var actions: PoolStringArray
export (Array, NodePath) var actions_textures_paths: Array
export (Array, NodePath) var actions_labels_paths: Array

export (Array, int) var mouse_buttons_events: Array
export (Array, Texture) var mouse_buttons_textures: Array
export (Texture) var empty_key_texture: Texture

onready var enabling_animation: AnimationPlayer = $EnablingAnimation

var enabled: bool = false


func _ready() -> void:
	GameState.connect("input_map_changed", self, "_refresh_inputs")
	_refresh_inputs()


func _refresh_inputs() -> void:
	for i in actions.size():
		var action: String = actions[i]
		var texture_rect: TextureRect = get_node(actions_textures_paths[i])
		var label: Label = get_node(actions_labels_paths[i])
		
		var event: InputEvent = InputMap.get_action_list(action)[0]
		if event is InputEventMouseButton:
			var id: int = mouse_buttons_events.find(event.button_index)
			if id != -1:
				texture_rect.texture = mouse_buttons_textures[id]
				label.text = ""
		else:
			texture_rect.texture = empty_key_texture
			label.text = event.as_text()


func _on_PlayerCloseArea_body_entered(body: Node) -> void:
	if !enabled:
		enabled = true
		enabling_animation.play("enabled")
