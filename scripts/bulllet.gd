extends Area3D

var speed = 20
var direction:Vector3
var spawn:Vector3
var life_time = 5
var current_time
var power = 0

func _ready():
	position = spawn
	current_time = life_time
	scale = scale * power

func _physics_process(delta):
	#position += direction * speed * delta
	position += Vector3(direction.x, 0, direction.z).normalized() * speed * delta
	if(current_time > 0):
		current_time += -delta
	else:
		queue_free()

func _on_body_entered(body:CharacterBody3D):
	if body.collision_layer == 2:
		var rest_life = body._do_damage(power)
		if(rest_life == 0):
			queue_free()
		else:
			power = rest_life

func _set_power(pw) -> void:
	power = pw
