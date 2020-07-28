extends RigidBody2D


onready var s1 = preload("res://image/s1.png")
onready var s2 = preload("res://image/s2.png")
onready var s3 = preload("res://image/s3.png")

func _ready():
	randomize()
	setimage()
	pass
	
func setimage():
	var choose = int(rand_range(0,3))
	if choose == 0:
		$Sprite.texture = s1
		gravity_scale = 0.1
	if choose == 1:
		$Sprite.texture = s2
		gravity_scale = 0.3
	if choose == 2:
		$Sprite.texture = s3
		gravity_scale = 0.2
