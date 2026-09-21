## Arcade delivery vehicle with damage, camera, shake, and feedback.
extends CharacterBody3D

## Arcade vehicle tuning values.
@export var acceleration := 8.0
@export var braking := 12.0
@export var maximum_speed := 10.0
@export var reverse_speed := 4.0
@export var steering_sensitivity := 2.5
@export var turning_response := 3.0
@export var camera_distance := 6.0
@export var camera_height := 3.0
@export var camera_smoothing := 5.0
@export var camera_lookahead := 2.0
@export var screen_shake_intensity := 0.3
@export var impact_feedback_intensity := 0.5

const FLOOR_Y := 0.5
const TIMER_WARNING_THRESHOLD := 15.0
const SUCCESS_COLOR := Color(0.1, 0.8, 0.3)
const FAILURE_COLOR := Color(0.9, 0.2, 0.2)

var _cam: Camera3D
var _speed := 0.0
var _steer_input := 0.0
var health := 100.0
var damage := 0.0
var _shake_offset := Vector2.ZERO
var _impact_timer := 0.0
var _current_impact_intensity := 0.0
var _result_color := Color.WHITE
var _warning_flash := false

func _ready() -> void:
	add_to_group("vehicle")
	var box_mesh := BoxMesh.new()
	box_mesh.size = Vector3(1.6, 0.6, 3.0)
	var visual := MeshInstance3D.new()
	visual.mesh = box_mesh
	visual.position = Vector3(0, 0.3, 0)
	add_child(visual)

	var box_shape := BoxShape3D.new()
	box_shape.size = Vector3(1.6, 1.0, 3.0)
	var collision := CollisionShape3D.new()
	collision.shape = box_shape
	collision.position = Vector3(0, 0.5, 0)
	add_child(collision)

	_cam = Camera3D.new()
	_cam.position = Vector3(0, camera_height, -camera_distance)
	_cam.current = true
	add_child(_cam)

	position.y = FLOOR_Y

func _physics_process(delta: float) -> void:
	var accel_input := Input.get_axis("accelerate", "brake")
	var steer_input := Input.get_axis("steer_left", "steer_right")

	if accel_input > 0.0:
		_speed = move_toward(_speed, maximum_speed, acceleration * delta)
	elif accel_input < 0.0:
		_speed = move_toward(_speed, -reverse_speed, braking * delta)
	else:
		_speed = move_toward(_speed, 0.0, braking * delta)

	var direction := -transform.basis.z * _speed
	velocity = Vector3(direction.x, 0.0, direction.z)

	if steer_input != 0.0 and abs(_speed) > 0.1:
		rotate_y(-steer_input * turning_response * delta * (1.0 - clamp(abs(_speed) / maximum_speed, 0.0, 0.5)))

	position.y = FLOOR_Y
	move_and_slide()

	_update_camera(delta)
	_update_screen_shake(delta)
	_update_impact_feedback(delta)

func _update_camera(delta: float) -> void:
	if _cam == null:
		return
	var look_ahead: Vector3 = -transform.basis.z * camera_lookahead * clamp(_speed / maximum_speed, 0.0, 1.0)
	var target_pos: Vector3 = global_position + Vector3(0, camera_height, -camera_distance) + look_ahead
	_cam.global_position = _cam.global_position.lerp(target_pos, camera_smoothing * delta)
	_cam.look_at(global_position + look_ahead, Vector3.UP)

func _update_screen_shake(delta: float) -> void:
	if not _cam or not is_instance_valid(_cam):
		return
	var _sm := _get_save_manager()
	if _sm and is_instance_valid(_sm) and not _sm.is_screenshake_on():
		_cam.rotation = Vector3.ZERO
		return
	if _impact_timer > 0.0:
		_impact_timer -= delta
		_shake_offset = Vector2(
			randf_range(-1.0, 1.0) * _current_impact_intensity,
			randf_range(-1.0, 1.0) * _current_impact_intensity
		)
	elif abs(_speed) > 0.1:
		_shake_offset = Vector2(
			randf_range(-1.0, 1.0) * screen_shake_intensity * abs(_speed) / 10.0,
			randf_range(-1.0, 1.0) * screen_shake_intensity * abs(_speed) / 10.0
		)
	else:
		_shake_offset = _shake_offset.lerp(Vector2.ZERO, 0.2)
	_cam.rotation_degrees = Vector3(_shake_offset.y, 0, _shake_offset.x)

func _get_save_manager() -> Node:
	var root := get_tree().current_scene
	if root and root.has_node("SaveManager"):
		return root.get_node("SaveManager")
	return null

func _update_impact_feedback(delta: float) -> void:
	pass

func trigger_impact(intensity: float) -> void:
	_impact_timer = maxf(_impact_timer, 0.3)
	_current_impact_intensity = intensity

func trigger_success_feedback() -> void:
	_result_color = SUCCESS_COLOR

func trigger_failure_feedback() -> void:
	_result_color = FAILURE_COLOR

func apply_damage(amount: float) -> void:
	health = maxf(health - amount, 0.0)
	damage += amount
	trigger_impact(amount * 0.05)

func repair() -> void:
	health = 100.0
	damage = 0.0

func reset() -> void:
	position = Vector3(0, FLOOR_Y, 0)
	rotation = Vector3.ZERO
	_speed = 0.0
	velocity = Vector3.ZERO
	health = 100.0
	damage = 0.0
	_shake_offset = Vector2.ZERO
	_impact_timer = 0.0
	_result_color = Color.WHITE
