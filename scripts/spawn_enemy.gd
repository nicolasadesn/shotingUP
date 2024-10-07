extends Node3D
var canSpawn:bool = false
var ray:Array[RayCast3D]

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	for elem in get_children():
		if(is_instance_of(elem, RayCast3D)):
			ray.push_back(elem)

func _get_arr_can_spawn() -> Array:
	var ray_can_spawn: Array
	for item in ray:
		if(item.is_colliding()):
			ray_can_spawn.push_back(item)
	if ray_can_spawn.size() > 0:
		return ray_can_spawn
	else:
		return []

func _get_spawn_location() -> Vector3:
	var arr:Array = _get_arr_can_spawn()
	if arr.size() > 0 :
		var spawn_select_number = rng.randf_range(0, arr.size())
		return arr[spawn_select_number].position
	else:
		return Vector3(0,2,0)
		
