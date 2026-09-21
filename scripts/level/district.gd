## District blockout: depot, safe route, shortcut, barrier, repair, destination, collapse boundary.
extends Node3D

@export var road_width := 4.0
@export var road_length := 30.0
@export var block_width := 16.0
@export var block_height := 4.0
@export var barrier_position := Vector3(0, 0.5, -5.0)
@export var repair_position := Vector3(-6.0, 0.5, 5.0)
@export var destination_position := Vector3(0.0, 0.5, -14.0)

var _floor := MeshInstance3D.new()
var _shortcut_floor := MeshInstance3D.new()
var _safe_floor := MeshInstance3D.new()
var _barrier_instance: MeshInstance3D
var _repair_zone: Area3D
var _destination_zone: Area3D
var _depot: MeshInstance3D
var _building_left := MeshInstance3D.new()
var _building_right := MeshInstance3D.new()
var _collapse_boundary := MeshInstance3D.new()
var _marker_shortcut := MeshInstance3D.new()
var _marker_destination := MeshInstance3D.new()

func _ready() -> void:
	_build_floor()
	_build_buildings()
	_build_barrier()
	_build_repair_station()
	_build_destination()
	_build_depot()
	_build_route_markers()
	_build_collapse_boundary()

func _build_floor() -> void:
	var road_mat := StandardMaterial3D.new()
	road_mat.albedo_color = Color(0.25, 0.25, 0.28, 1)

	var safe_mat := StandardMaterial3D.new()
	safe_mat.albedo_color = Color(0.2, 0.5, 0.25, 0.4)

	var shortcut_mat := StandardMaterial3D.new()
	shortcut_mat.albedo_color = Color(0.5, 0.4, 0.15, 0.4)

	var safe_road := BoxMesh.new()
	safe_road.size = Vector3(road_width, 0.1, road_length * 0.5)
	_safe_floor.mesh = safe_road
	_safe_floor.material_override = safe_mat
	_safe_floor.position = Vector3(road_width + 2.0, 0.05, road_length * 0.25)
	add_child(_safe_floor)

	var shortcut_road := BoxMesh.new()
	shortcut_road.size = Vector3(road_width, 0.1, road_length * 0.5)
	_shortcut_floor.mesh = shortcut_road
	_shortcut_floor.material_override = shortcut_mat
	_shortcut_floor.position = Vector3(-(road_width + 2.0), 0.05, road_length * 0.25)
	add_child(_shortcut_floor)

	var main_road := BoxMesh.new()
	main_road.size = Vector3(road_width, 0.1, road_length)
	_floor.mesh = main_road
	_floor.material_override = road_mat
	_floor.position = Vector3(0, 0.05, 0)
	add_child(_floor)

func _build_buildings() -> void:
	var bld_mat := StandardMaterial3D.new()
	bld_mat.albedo_color = Color(0.35, 0.35, 0.35, 1)

	var bld_left_mesh := BoxMesh.new()
	bld_left_mesh.size = Vector3(block_width - road_width, block_height, 4.0)
	_building_left.mesh = bld_left_mesh
	_building_left.material_override = bld_mat
	_building_left.position = Vector3(-block_width / 2.0, block_height / 2.0, 0)
	add_child(_building_left)

	var bld_right_mesh := BoxMesh.new()
	bld_right_mesh.size = Vector3(block_width - road_width, block_height, 4.0)
	_building_right.mesh = bld_right_mesh
	_building_right.material_override = bld_mat
	_building_right.position = Vector3(block_width / 2.0, block_height / 2.0, 0)
	add_child(_building_right)

func _build_barrier() -> void:
	var barrier_mat := StandardMaterial3D.new()
	barrier_mat.albedo_color = Color(0.8, 0.2, 0.15, 1)

	var barrier_mesh := BoxMesh.new()
	barrier_mesh.size = Vector3(road_width, 2.0, 0.6)
	_barrier_instance = MeshInstance3D.new()
	_barrier_instance.mesh = barrier_mesh
	_barrier_instance.material_override = barrier_mat
	_barrier_instance.position = barrier_position
	add_child(_barrier_instance)

func _build_repair_station() -> void:
	var repair_mat := StandardMaterial3D.new()
	repair_mat.albedo_color = Color(0.15, 0.3, 0.8, 0.5)

	_repair_zone = Area3D.new()
	var repair_shape := CollisionShape3D.new()
	repair_shape.shape = SphereShape3D.new()
	repair_shape.shape.radius = 2.0
	_repair_zone.add_child(repair_shape)
	var repair_visual := MeshInstance3D.new()
	var repair_mesh := CylinderMesh.new()
	repair_mesh.height = 3.0
	repair_mesh.top_radius = 1.5
	repair_mesh.bottom_radius = 1.5
	repair_visual.mesh = repair_mesh
	repair_visual.material_override = repair_mat
	repair_visual.position = Vector3(0, 1.5, 0)
	_repair_zone.add_child(repair_visual)
	_repair_zone.position = repair_position
	add_child(_repair_zone)

func _build_destination() -> void:
	var dest_mat := StandardMaterial3D.new()
	dest_mat.albedo_color = Color(0.1, 0.7, 0.25, 0.7)

	_destination_zone = Area3D.new()
	var dest_shape := CollisionShape3D.new()
	dest_shape.shape = SphereShape3D.new()
	dest_shape.shape.radius = 2.5
	_destination_zone.add_child(dest_shape)
	var dest_visual := MeshInstance3D.new()
	var dest_mesh := CylinderMesh.new()
	dest_mesh.height = 4.0
	dest_mesh.top_radius = 2.0
	dest_mesh.bottom_radius = 2.0
	dest_visual.mesh = dest_mesh
	dest_visual.material_override = dest_mat
	dest_visual.position = Vector3(0, 2.0, 0)
	_destination_zone.add_child(dest_visual)
	_destination_zone.position = destination_position
	add_child(_destination_zone)

func _build_depot() -> void:
	var depot_mat := StandardMaterial3D.new()
	depot_mat.albedo_color = Color(0.4, 0.4, 0.45, 1)
	var depot_mesh := BoxMesh.new()
	depot_mesh.size = Vector3(5.0, 3.0, 4.0)
	_depot = MeshInstance3D.new()
	_depot.mesh = depot_mesh
	_depot.material_override = depot_mat
	_depot.position = Vector3(0, 1.5, 10.0)
	add_child(_depot)

func _build_route_markers() -> void:
	var yellow_mat := StandardMaterial3D.new()
	yellow_mat.albedo_color = Color(0.9, 0.8, 0.1, 0.8)

	var shortcut_marker_mesh := BoxMesh.new()
	shortcut_marker_mesh.size = Vector3(1.0, 1.0, 1.0)
	_marker_shortcut.mesh = shortcut_marker_mesh
	_marker_shortcut.material_override = yellow_mat
	_marker_shortcut.position = Vector3(-(road_width + 2.0), 1.0, -8.0)
	add_child(_marker_shortcut)

	var dest_marker_mesh := BoxMesh.new()
	dest_marker_mesh.size = Vector3(1.0, 1.5, 1.0)
	_marker_destination.mesh = dest_marker_mesh
	_marker_destination.material_override = yellow_mat
	_marker_destination.position = Vector3(0, 2.5, -16.0)
	add_child(_marker_destination)

func _build_collapse_boundary() -> void:
	var collapse_mat := StandardMaterial3D.new()
	collapse_mat.albedo_color = Color(0.6, 0.1, 0.1, 0.15)
	var collapse_mesh := BoxMesh.new()
	collapse_mesh.size = Vector3(block_width * 2.0, block_height, road_length + 6.0)
	_collapse_boundary.mesh = collapse_mesh
	_collapse_boundary.material_override = collapse_mat
	_collapse_boundary.position = Vector3(0, block_height / 2.0, -2.0)
	add_child(_collapse_boundary)

func get_barrier() -> MeshInstance3D:
	return _barrier_instance

func is_shortcut_open() -> bool:
	return _barrier_instance == null or not is_instance_valid(_barrier_instance)

func remove_barrier() -> void:
	if _barrier_instance and is_instance_valid(_barrier_instance):
		_barrier_instance.queue_free()

func repair_vehicle() -> void:
	pass

func get_destination_zone() -> Area3D:
	return _destination_zone

func get_repair_zone() -> Area3D:
	return _repair_zone
