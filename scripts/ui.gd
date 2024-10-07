extends Control

var lbls:Dictionary

var hp_text
var power_text
var speed_text
var aspd_text

var hp_value:int
var power_value:float
var speed_value:float
var aspd_value:float

# Called when the node enters the scene tree for the first time.
func _ready():
	# Obtengo referencia a cada elemento del hud y guardo los textos q tienen default
	# para poder modificarlos directamente del hud
	lbls.hp = $lbl_hp
	hp_text = lbls.hp.text
	#lbls.hp.text = hp_text + "1"
	lbls.power = $lbl_power
	power_text = lbls.power.text
	lbls.speed = $lbl_speed
	speed_text = lbls.speed.text
	lbls.aspd = $lbl_aspd
	aspd_text = lbls.aspd.text

func _refresh_lbls_values():
	lbls.hp.text = hp_text + str(hp_value)
	lbls.power.text = power_text + str(power_value)
	lbls.speed.text = speed_text + str(speed_value)
	lbls.aspd.text = aspd_text + str(aspd_value)
