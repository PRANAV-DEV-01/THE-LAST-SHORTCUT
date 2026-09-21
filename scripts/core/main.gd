## Main controller: delivery loop with timer, success/failure, restart.
extends Node3D

const DELIVERY_TIME_LIMIT := 90.0

@onready var _district := $District as Node3D
@onready var _vehicle: CharacterBody3D = $District/Vehicle as CharacterBody3D

var _timer := Timer.new()
var _time_remaining := DELIVERY_TIME_LIMIT
var _state := 0
var _best_score := 0
var _best_time := 0.0

enum State { IDLE = 0, RUNNING = 1, SUCCESS = 2, FAILURE = 3 }

func _ready() -> void:
	_setup_timer()
	_setup_signals()
	_state = State.IDLE
	_start_delivery()

func _setup_timer() -> void:
	_timer.wait_time = 1.0
	_timer.one_shot = false
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)

func _setup_signals() -> void:
	if _district and _district.has_signal("delivery_complete"):
		_district.delivery_complete.connect(_on_delivery_complete)

func _on_timer_timeout() -> void:
	if _state != State.RUNNING:
		return
	_time_remaining -= 1.0
	if _time_remaining <= 0.0:
		_fail()

func _start_delivery() -> void:
	_state = State.RUNNING
	_time_remaining = DELIVERY_TIME_LIMIT
	_timer.start()
	print("DELIVERY_STARTED time_limit=", DELIVERY_TIME_LIMIT)

func _succeed() -> void:
	_state = State.SUCCESS
	_timer.stop()
	var score := _calculate_score()
	print("DELIVERY_SUCCESS score=", score, " time=", DELIVERY_TIME_LIMIT - _time_remaining)

func _fail() -> void:
	_state = State.FAILURE
	_timer.stop()
	print("DELIVERY_FAILED time_up=true")

func _calculate_score() -> int:
	var time_bonus := int(maxf(_time_remaining, 0.0) * 10)
	var health_penalty := int(100.0 - _get_vehicle_health()) * 2
	var shortcut_bonus := 50 if _district.is_shortcut_open() else 0
	return maxi(time_bonus - health_penalty + shortcut_bonus, 0)

func _get_vehicle_health() -> float:
	if _vehicle and is_instance_valid(_vehicle):
		return _vehicle.health
	return 100.0

func _restart() -> void:
	_state = State.IDLE
	_time_remaining = DELIVERY_TIME_LIMIT
	_timer.stop()
	if _vehicle and is_instance_valid(_vehicle):
		_vehicle.reset()
	if _district and _district.has_method("reset"):
		_district.call("reset")
	print("DELIVERY_RESTARTED")

func _on_delivery_complete(vehicle: CharacterBody3D) -> void:
	if _state == State.RUNNING:
		_succeed()

func get_state() -> int:
	return _state

func get_time_remaining() -> float:
	return _time_remaining

func get_score() -> int:
	if _state == State.SUCCESS or _state == State.FAILURE:
		return _calculate_score()
	return 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		_restart()
	if event.is_action_pressed("pause") and _state == State.RUNNING:
		get_tree().paused = not get_tree().paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		_restart()
