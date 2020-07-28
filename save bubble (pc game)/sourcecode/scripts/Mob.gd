extends Area2D

export (PackedScene) var Gcoin
export(PackedScene) var Scoin
export(PackedScene) var Plife
export(PackedScene) var Pinvisible
export(PackedScene) var Pshield
export(PackedScene) var Shield

var velocity = Vector2(rand_range(2,6),0)
var dir = 0
var fishscale = 1




func _ready():
	randomize()
	
	$Node2D/fish.flip_v = utils.fishflip
	pass

func _process(delta):
	pass



func _physics_process(delta):
	position += velocity.rotated(dir)
	if (position.x > utils.sizex+150 or position.x < -150 or position.y > utils.sizey +50 or position.y < -150):
		queue_free()
	pass


#func screen_exit():
#	queue_free()
#func _on_VisibilityNotifier2D_screen_exited():
#	queue_free()
#
#
#
#
#
#func _on_Area2D_body_shape_entered(body_id, body, body_shape, local_shape):
#	pass # replace with function body
#
#
##func _on_Timer_timeout():
##	$Tween.interpolate_method(self,"translate",Vector2(0,0),velocity,0.3,Tween.TRANS_QUAD,Tween.EASE_OUT,0.1)
##	$Tween.start()


func _on_Mob_area_entered(area):
	if area.is_in_group("shield"):
		create_item()


func create_item():
	var choose = int(rand_range(0,8))
	if choose == 0:
		create_power()
	else:
		
		create_coin()
	pass


func create_coin():
	var item = int(rand_range(0,2))
	var coinn
	if item == 0:
		 coinn = Gcoin
	else:
		 coinn = Scoin
	
	var no = int((270*fishscale)/70)
	print(no)
	$Node2D/fish.hide()
	$CollisionShape2D.set_disabled(true)
	velocity = Vector2()
	for i in range (0,no):
		var coin = coinn.instance()
		add_child(coin)
		
		coin.global_position = $Node2D/Path2D/PathFollow2D.global_position
		coin.global_rotation = 0
		$Node2D/Path2D/PathFollow2D.offset += 70
	yield(utils.create_timer(5),"timeout")
	queue_free()

func create_power():
	var item = int(rand_range(0,3))
	var powerr
	$Node2D/fish.hide()
	$CollisionShape2D.set_disabled(true)
	if item == 0:
		powerr = Plife
	
	elif item ==1:
		powerr = Pinvisible
	else:
		powerr = Pshield
	var power = powerr.instance()
	add_child(power)
	if int(rand_range(0,4)):
		velocity = Vector2()
	power.scale = Vector2(0.5,0.5)
	power.global_position = $Node2D/fish.global_position
	power.global_rotation = 0
	
	


