extends Node3D
@export var enemy_obj: PackedScene
@onready var player = $Player
@onready var ui = $UI
@export var speed_spawn_enemy = 5
@export var cant_enemy_per_spawn = 2
var delay_beetween_spawn
var spawn_cd = 4
var spawn_manager
var spawn_location: Vector3

var count_mobs = 1

func _ready():
	delay_beetween_spawn = spawn_cd
	spawn_manager = $Camera3D/SpawnEnemy

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if delay_beetween_spawn > 0:
		delay_beetween_spawn -= speed_spawn_enemy * delta
	else:
		spawn_enemy()

func spawn_enemy():
	var enemy = enemy_obj.instantiate()
	enemy.p_target = player
	delay_beetween_spawn = spawn_cd
	enemy.position = spawn_manager._get_spawn_location()
	if(count_mobs % 10 != 0):
		count_mobs += 1
	else:
		#spawn boss
		enemy.scale = Vector3(3,2,3)
		enemy.max_life = 10
		count_mobs += 1
		
	add_child(enemy)

func _reload_ui():
	ui.hp_value = player.hp
	ui.speed_value = player.SPEED
	ui.power_value = player.power
	ui.aspd_value = player.cd_base_shoot
	ui._refresh_lbls_values()
