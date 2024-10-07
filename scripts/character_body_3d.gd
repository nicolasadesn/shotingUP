extends CharacterBody3D

# Stats
@export var SPEED = 10.0
@export var cd_base_shoot:float = 1
@export var power = 1.0
@export var hp = 10

@export var bulletObject:PackedScene
@export var bulletSpawnLocation:Node3D
@export var camera:Camera3D
@export var world:Node3D
var camera_original_pos
var speed_cam = 3

var can_shoot = true
var coldown_shoot

var power_up_text:Label3D
var timer_buff:Timer
var anim_play:AnimationPlayer

func _ready():
	coldown_shoot = cd_base_shoot
	camera_original_pos = camera.position
	power_up_text = $PowerUpText
	timer_buff = $Timer_Buff_Text
	anim_play = $AnimationPlayer

func _physics_process(delta):
	if(camera):
		camera.position = lerp(camera.position, camera_original_pos + position, speed_cam*delta)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# mueve con respecto donde mira la camara
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var direction = input_dir
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.y * SPEED
		anim_play.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		anim_play.play("idle")
	
	look_at(look_at_cursor(), Vector3.UP)

	if Input.is_action_pressed("shoot") && can_shoot:
		shoot()
	
	if coldown_shoot > 0:
		coldown_shoot -= delta
	else:
		can_shoot = true
	
	move_and_slide()

func shoot():
	var b = bulletObject.instantiate()
	b.direction = look_at_cursor() - bulletSpawnLocation.global_position
	b.spawn = bulletSpawnLocation.global_position
	b._set_power(power)
	$"..".add_child(b)
	can_shoot = false
	coldown_shoot = cd_base_shoot

func look_at_cursor() -> Vector3:
	var target_plane_mouse = Plane(Vector3(0,1,0), position.y)
	var ray_lenght = 1000
	var mouse_position = get_viewport().get_mouse_position()
	var from = $"../Camera3D".project_ray_origin(mouse_position)
	var to = from + $"../Camera3D".project_ray_normal(mouse_position) * ray_lenght
	var cursosr_position_on_plane = target_plane_mouse.intersects_ray(from, to)
	if cursosr_position_on_plane:
		return cursosr_position_on_plane
	else:
		return Vector3(0,0,0)

func _set_buff(buff):
	if(buff == "VEL"):
		SPEED += 1 / SPEED
		power_up_text.text = "Speed UP!"
	elif(buff == "POWER"):
		power = power + 1 / power
		power_up_text.text = "Power UP!"
	elif(buff == "ASPD"):
		cd_base_shoot -= cd_base_shoot * 0.1
		power_up_text.text = "Attack Speed UP!"
	timer_buff.start()
	anim_play.play("power_up")
	world._reload_ui()

func _on_timer_buff_text_timeout():
	power_up_text.text = ""
	
