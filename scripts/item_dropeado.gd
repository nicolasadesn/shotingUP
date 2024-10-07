extends Node3D

var TypeOfBuff = ["VEL", "ASPD", "POWER"]
var rnd = RandomNumberGenerator.new()
var buff
@export var materials:Array[Material]

# Called when the node enters the scene tree for the first time.
func _ready():
	var random = rnd.randf_range(0, TypeOfBuff.size())
	var model:CSGBox3D = $CSGBox3D

	buff = TypeOfBuff[random]
	if(buff == "VEL"):
		model.material = materials[0]
	elif(buff == "ASPD"):
		model.material = materials[1]
	elif(buff == "POWER"):
		model.material = materials[2]
		
		

func _on_area_3d_body_entered(body):
	if(body.collision_layer == 1):
		body._set_buff(buff)
		queue_free()
	pass # Replace with function body.
