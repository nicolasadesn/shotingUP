extends CharacterBody3D

const SPEED = 330.0
var p_target:CharacterBody3D
var max_life = 1
var life
var prob_drop_elem
var rng = RandomNumberGenerator.new()
@export var item_scene:PackedScene

func _ready():
	life = max_life
	prob_drop_elem = rng.randf_range(0, 100)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if(p_target):
		var input_dir = p_target.position
		#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		var direction = (Vector3(input_dir.x, 0, input_dir.z) - position).normalized()
		if direction:
			velocity.x = direction.x * SPEED * delta
			velocity.z = direction.z * SPEED * delta
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)		
	move_and_slide()


func _do_damage(power:int) -> int:
	var rest_power = power - life
	life -= power
	
	if (life > 0):
		#print("el enemigo quedo en ", life)
		return 0
	else:
		_dead()
		return rest_power

func _dead():
	if(prob_drop_elem > rng.randf_range(70,100)):
		var item = item_scene.instantiate()
		item.position = position
		get_tree().current_scene.add_child(item)
	queue_free()
	
