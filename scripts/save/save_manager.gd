## Local save manager for The Last Shortcut.
## Save format: {saveversion, bestscore, besttime, screenshake}
extends Node

const SAVE_FILE := "user://save_data.json"
const CURRENT_SAVE_VERSION := 1

var _data := {
	"saveversion": CURRENT_SAVE_VERSION,
	"bestscore": 0,
	"besttime": 0.0,
	"screenshake": true,
}

func _ready() -> void:
	load_data()

func save_data() -> void:
	var json_str := JSON.stringify(_data, "\t")
	var file := FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	if file == null:
		print("SAVE_ERROR: cannot open file")
		return
	file.store_string(json_str)
	file.close()
	print("SAVE: saved")

func load_data() -> void:
	var file := FileAccess.open(SAVE_FILE, FileAccess.READ)
	if file == null:
		print("SAVE: no existing save file, using defaults")
		return

	var json_str := file.get_as_text()
	file.close()

	var json := JSON.new()
	var err := json.parse(json_str)
	if err != OK:
		print("SAVE: corrupt save file, resetting")
		_reset_data()
		return

	var parsed: Variant = json.data
	if not parsed is Dictionary:
		print("SAVE: invalid save format, resetting")
		_reset_data()
		return

	var d: Dictionary = parsed as Dictionary
	if not d.has("saveversion") or int(d["saveversion"]) < CURRENT_SAVE_VERSION:
		print("SAVE: old version, migrating or resetting")
		if d.has("saveversion") and int(d["saveversion"]) > 0:
			_migrate(d)
		else:
			_reset_data()
		return

	_data["bestscore"] = int(d.get("bestscore", 0))
	_data["besttime"] = float(d.get("besttime", 0.0))
	_data["screenshake"] = bool(d.get("screenshake", true))
	print("SAVE: loaded bestscore=", _data["bestscore"], " besttime=", _data["besttime"])

func _migrate(old: Dictionary) -> void:
	_data["bestscore"] = int(old.get("bestscore", 0))
	_data["besttime"] = float(old.get("besttime", 0.0))
	_data["screenshake"] = bool(old.get("screenshake", true))
	_data["saveversion"] = CURRENT_SAVE_VERSION
	save_data()
	print("SAVE: migrated to version ", CURRENT_SAVE_VERSION)

func _reset_data() -> void:
	_data = {
		"saveversion": CURRENT_SAVE_VERSION,
		"bestscore": 0,
		"besttime": 0.0,
		"screenshake": true,
	}
	save_data()
	print("SAVE: reset to defaults")

func get_best_score() -> int:
	return _data["bestscore"]

func get_best_time() -> float:
	return _data["besttime"]

func get_screenshake() -> bool:
	return _data["screenshake"]

func set_best_score(score: int) -> void:
	if score > _data["bestscore"]:
		_data["bestscore"] = score

func set_best_time(time: float) -> void:
	if time > 0.0 and (float(_data["besttime"]) == 0.0 or time < float(_data["besttime"])):
		_data["besttime"] = time

func toggle_screenshake() -> void:
	_data["screenshake"] = not _data["screenshake"]

func is_screenshake_on() -> bool:
	return _data["screenshake"]
