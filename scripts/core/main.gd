extends Node3D

@onready var _vehicle := $Vehicle as CharacterBody3D

func _ready() -> void:
	_input_map_setup()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		_vehicle.call("reset")
		get_tree().reload_current_scene()
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused

func _input_map_setup() -> void:
	pass
