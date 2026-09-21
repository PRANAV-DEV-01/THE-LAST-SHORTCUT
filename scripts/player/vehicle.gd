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

const FLOOR_Y := 0.5

var _cam: Camera3D
var _speed := 0.0
var _steer_input := 0.0

func _ready() -> void:
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

func _update_camera(delta: float) -> void:
	if _cam == null:
		return
	var target_pos := global_position + Vector3(0, camera_height, -camera_distance)
	_cam.global_position = _cam.global_position.lerp(target_pos, camera_smoothing * delta)
	_cam.look_at(global_position, Vector3.UP)

func reset() -> void:
	position = Vector3(0, FLOOR_Y, 0)
	rotation = Vector3.ZERO
	_speed = 0.0
	velocity = Vector3.ZERO
