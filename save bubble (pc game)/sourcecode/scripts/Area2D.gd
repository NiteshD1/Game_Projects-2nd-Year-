extends Area2D

signal game_over
signal color_change

export (int) var speed
export (int) var health
var direction = Vector2()




func _ready():
	utils.connect("pinvisible",self,"invisible",[20])

	pass

func _process(delta):
	direction = Vector2()
	if Input.is_action_pressed("ui_select"):
		direction.x = 1
		$AnimatedSprite.play("br")
	if Input.is_action_just_released("ui_select"):
		audio.get_node("Move").play()
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		$AnimatedSprite.play("bl")
	if Input.is_action_just_released("ui_left"):
		audio.get_node("Move").play()
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
		$AnimatedSprite.play("bu")
	if Input.is_action_just_released("ui_up"):
		audio.get_node("Move").play()
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
		$AnimatedSprite.play("bd")
	if Input.is_action_just_released("ui_down"):
		audio.get_node("Move").play()
#	else:
#		$AnimatedSprite.play("bm")

#
		
	     
	var velocity = direction.normalized() * speed * delta

	position += velocity
#	position.x = clamp(position.x,37,5184-33)
#	position.y = clamp(position.y,28,3456-33)
	
	
	





	pass # replace with function body



func invisible(var time):
	if time == 20:
		utils.haspower = true
	call_deferred("set_monitoring",false)
	$AnimatedSprite.set_self_modulate(Color(1,1,1,0.2))
	$AnimatedSprite/Particles2D.set_self_modulate(Color(1,1,1,0.2))
	yield(utils.create_timer(time),"timeout")
	$AnimatedSprite.set_self_modulate(Color(1,1,1,1))
	$AnimatedSprite/Particles2D.set_self_modulate(Color(1,1,1,1))
	if time == 20:
		utils.haspower = false
	call_deferred("set_monitoring",true)
	



func _on_Player_area_entered(area):
	print(area.name)
	if area.is_in_group("enemy"):
		audio.get_node("Gameover").play()
		utils.emit_signal("life")
		invisible(5)




func _on_Control_end():
	hide()
	speed = 0
	$CollisionShape2D.disabled = true
	pass # replace with function body
