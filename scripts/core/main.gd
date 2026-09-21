## Main controller: delivery loop, repair, scoring, results, save, screen shake.
extends Node3D

const DELIVERY_TIME_LIMIT := 90.0
const REPAIR_TIME_PENALTY := 8.0

@onready var _district := $District as Node3D
@onready var _vehicle: CharacterBody3D = $District/Vehicle as CharacterBody3D
@onready var _save_manager := $SaveManager as SaveManager

var _timer := Timer.new()
var _time_remaining := DELIVERY_TIME_LIMIT
var _state := 0
var _elapsed_time := 0.0
var _screenshake := true

enum State { IDLE = 0, RUNNING = 1, SUCCESS = 2, FAILURE = 3 }

func _ready() -> void:
	_setup_save()
	_setup_results()
	_setup_timer()
	_setup_signals()
	_state = State.IDLE
	_start_delivery()

func _setup_save() -> void:
	if _save_manager and is_instance_valid(_save_manager):
		_screenshake = _save_manager.is_screenshake_on()
		print("SAVE: bestscore=", _save_manager.get_best_score(), " besttime=", _save_manager.get_best_time(), " screenshake=", _screenshake)

func _setup_results() -> void:
	_results_label.name = "ResultsLabel"
	_results_label.position = Vector2(20, 20)
	_results_label.size = Vector2(600, 100)
	_results_label.custom_minimum_size = Vector2(600, 100)
	_results_label.add_theme_font_size_override("font_size", 20)
	_results_label.text = ""
	_results_label.visible = false
	add_child(_results_label)

func _setup_timer() -> void:
	_timer.wait_time = 1.0
	_timer.one_shot = false
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)

func _setup_signals() -> void:
	if _district and _district.has_signal("delivery_complete"):
		_district.delivery_complete.connect(_on_delivery_complete)
	if _district and _district.has_signal("vehicle_repaired"):
		_district.vehicle_repaired.connect(_on_vehicle_repaired)

func _on_timer_timeout() -> void:
	if _state != State.RUNNING:
		return
	_time_remaining -= 1.0
	_elapsed_time += 1.0
	_update_results_label()
	if _time_remaining <= 0.0:
		_fail()

func _start_delivery() -> void:
	_state = State.RUNNING
	_time_remaining = DELIVERY_TIME_LIMIT
	_elapsed_time = 0.0
	_timer.start()
	_update_results_label()
	print("DELIVERY_STARTED time_limit=", DELIVERY_TIME_LIMIT)

func _succeed() -> void:
	_state = State.SUCCESS
	_timer.stop()
	var score := _calculate_score()
	_save_best(score)
	_update_results_label()
	print("DELIVERY_SUCCESS score=", score, " time=", _elapsed_time)

func _fail() -> void:
	_state = State.FAILURE
	_timer.stop()
	_update_results_label()
	print("DELIVERY_FAILED time_up=true")

func _on_vehicle_repaired(vehicle: CharacterBody3D) -> void:
	_time_remaining = maxf(_time_remaining - REPAIR_TIME_PENALTY, 0.0)
	print("REPAIR_TIME_PENALTY penalty=", REPAIR_TIME_PENALTY, " remaining=", _time_remaining)

func _calculate_score() -> int:
	var time_bonus := int(maxf(_time_remaining, 0.0) * 10)
	var health_penalty := int(100.0 - _get_vehicle_health()) * 2
	var shortcut_bonus := 50 if _district.is_shortcut_open() else 0
	return maxi(time_bonus - health_penalty + shortcut_bonus, 0)

func _get_vehicle_health() -> float:
	if _vehicle and is_instance_valid(_vehicle):
		return _vehicle.health
	return 100.0

func _save_best(score: int) -> void:
	if _save_manager and is_instance_valid(_save_manager):
		_save_manager.set_best_score(score)
		_save_manager.set_best_time(_elapsed_time)
		_save_manager.save_data()
		print("SAVE: saved bestscore=", _save_manager.get_best_score(), " besttime=", _save_manager.get_best_time())

func _toggle_screenshake() -> void:
	if _save_manager and is_instance_valid(_save_manager):
		_save_manager.toggle_screenshake()
		_screenshake = _save_manager.is_screenshake_on()
		print("SCREENSHAKE ", _screenshake)

func _restart() -> void:
	_state = State.IDLE
	_time_remaining = DELIVERY_TIME_LIMIT
	_elapsed_time = 0.0
	_timer.stop()
	if _vehicle and is_instance_valid(_vehicle):
		_vehicle.reset()
	if _district and _district.has_method("reset"):
		_district.call("reset")
	_update_results_label()
	_start_delivery()
	print("DELIVERY_RESTARTED")

func _update_results_label() -> void:
	if not is_instance_valid(_results_label):
		return
	_match _state:
		State.IDLE:
			_results_label.text = "DELIVERY STARTED"
			_results_label.visible = true
		State.RUNNING:
			_results_label.text = "Time: " + str(ceil(_time_remaining)) + "s"
			_results_label.visible = true
		State.SUCCESS:
			var score := _calculate_score()
			var best := 0
			if _save_manager and is_instance_valid(_save_manager):
				best = _save_manager.get_best_score()
			_results_label.text = "SUCCESS! Score: " + str(score) + " Best: " + str(best)
			_results_label.visible = true
		State.FAILURE:
			_results_label.text = "FAILED - Time is up!"
			_results_label.visible = true

func get_state() -> int:
	return _state

func get_time_remaining() -> float:
	return _time_remaining

func get_elapsed_time() -> float:
	return _elapsed_time

func get_score() -> int:
	if _state == State.SUCCESS or _state == State.FAILURE:
		return _calculate_score()
	return 0

func get_best_score() -> int:
	if _save_manager and is_instance_valid(_save_manager):
		return _save_manager.get_best_score()
	return 0

func get_best_time() -> float:
	if _save_manager and is_instance_valid(_save_manager):
		return _save_manager.get_best_time()
	return 0.0

func get_screenshake() -> bool:
	return _screenshake

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		_restart()
	if event.is_action_pressed("pause") and _state == State.RUNNING:
		get_tree().paused = not get_tree().paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		_restart()
