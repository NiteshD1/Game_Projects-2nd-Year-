extends Node2D

signal playerout
var loweritem
var higheritem
var lowerdrop 
var higherdrop
var no
var sitem
var bitem
var level = 1
var cameraspeedlimit = 200
var cameraspeedincrease =2
var velocitylimit =280
var velocityincrease =2
var accelerationc = 1
var accelerationv = 1
var vvelocity
var gemtimeno = 0
var starlevel
var balltimelimit = 0.4
var r 
var g
var b
var cr 



export(PackedScene) var Rectangle
export(PackedScene) var Ballg
export(PackedScene) var Spike
export(PackedScene) var Starb
export(PackedScene) var Roter
export(PackedScene) var Starblack
export(PackedScene) var Square
export(PackedScene) var Gem





onready var main = preload("res://scene/mainui.tscn")


var gemp = 0
var canout = true

func _ready():
	$Player.show()
	utils.gem = 0
	vvelocity = $Player.velocity
#	level = int(utils.loadfile())
	select_level()
	audio.get_node("bg").play()
	$finish/AnimationPlayer.play("New Anim")
	print(utils.level)
	randomize()

	

func _process(delta):
#	if $Bg0.position.y > $Camera2D/Position2D.global_position.y:
#		$Bg0.position.y = $Bg1.position.y - 200
#	if $Bg1.position.y > $Camera2D/Position2D.global_position.y:
#		$Bg1.position.y = $Bg2.position.y - 200
#	if $Bg2.position.y > $Camera2D/Position2D.global_position.y:
#		$Bg2.position.y = $Bg0.position.y - 200
	if ($Player.position.y > $Camera2D.position.y + 420 or $Player.position.y < $Camera2D.position.y -30 ) and canout:
		emit_signal("playerout")
		$Camera2D.cameramove = 30
		$Timer.stop()
		$balltimer.stop()
		$itemtimer.stop()
		$Player.hide()
		canout = false
	if $Camera2D.position.y < -12050:
		$Camera2D.cameramove = 0
		$Timer.stop()
	if $Player.position.y < $Camera2D.position.y + 60 :
		$Player.set_linear_velocity(Vector2(0,10))
		
	pass








# for player----------------------------
func _on_Area2D_body_entered(body):

	if body.is_in_group("last"):
		$itemtimer.start()
		print("yaa")




func _on_Area2D_body_exited(body):
	body.queue_free()
	print("y")
	pass # replace with function body




#
## touch input-----------------
#func _on_left_pressed():
#		$Player.set_linear_velocity(Vector2(-$Player.velocity,-$Player.velocity))
#		$Player.set_angular_velocity(2)
#		audio.get_node("tap").play()
#
#
#
#func _on_middle_pressed():
#		$Player.set_linear_velocity(Vector2(0,-$Player.velocity))
#		$Player.set_angular_velocity(8)
#		audio.get_node("tap").play()
#
#
#
#func _on_right_pressed():
#		$Player.set_linear_velocity(Vector2($Player.velocity,-$Player.velocity))
#		$Player.set_angular_velocity(2)
#		audio.get_node("tap").play()
		

##### touch input ends ----------------------------

##### gem entered----------------

func _on_Area2D_area_entered(area):
	if area.is_in_group("gem"):
		print("g")





func _on_Area2D_area_exited(area):
	area.queue_free()
	print("y")
	pass # replace with function body










func _on_backretry_pressed():
	audio.get_node("click").play()
	set_modulate(Color(1,1,1,0.2))
	$ui/CanvasLayer/Popupdied.hide()
	$ui/CanvasLayer/Popuprestart.show()
	ProjectSettings.set_setting("rendering/environment/default_clear_color", Color(0.11,0.05,0.23))
	get_tree().paused = true
	$ui/CanvasLayer/Popuprestart.set_pause_mode(Node.PAUSE_MODE_PROCESS)
	$ui/Node2D.set_pause_mode(Node.PAUSE_MODE_PROCESS)
	pass # replace with function body





func _on_finish_body_entered(body):
	if body.is_in_group("player"):
		$ui/CanvasLayer/Popuplevel.show()
		$ui/CanvasLayer/Popuplevel/AnimationPlayer.play("New Anim")
		audio.get_node("bg").stop()
		audio.get_node("level").play()
		var s = utils.loadfile()
		if utils.gem > 0.5* utils.gemno:
			s[utils.level] = 3
		elif utils.gem > 0.3 * utils.gemno:
			s[utils.level] = 2
		else:
			s[utils.level] = 1
		starlevel = utils.level
		utils.save(s)
		$ui/CanvasLayer/Popuplevel/star/AnimationPlayer.play("New Anim")
		
		if utils.level >= utils.maxlevel:
			utils.level = 1
		else:
			utils.level += 1
	
		var p = utils.loadfile()
	
		
		var previous = p[0]
		if utils.level > previous:
			p[0] = utils.level
			utils.save(p)
	
		get_tree().paused = true
		$ui/CanvasLayer/Popuplevel.set_pause_mode(Node.PAUSE_MODE_PROCESS)
	print("hiiii")
	pass # replace with function body


func _on_cross_pressed():
	audio.get_node("click").play()
	set_modulate(Color(1,1,1,0.2))
	$ui/CanvasLayer/Popuplevel.hide()
	$ui/CanvasLayer/Popuprestart.show()
	ProjectSettings.set_setting("rendering/environment/default_clear_color", Color(0.11,0.05,0.23))
	get_tree().paused = true
	$ui/CanvasLayer/Popuprestart.set_pause_mode(Node.PAUSE_MODE_PROCESS)
	pass # replace with function body


func _on_Timer_timeout():
	r += 0.003
	g += 0.005
	b += 0.01
	if accelerationv> 0.5:
		accelerationv -= 0.01
	if accelerationc > 0.65:
		accelerationc -= 0.01
	if $Camera2D.cameramove < cameraspeedlimit: 
		$Camera2D.cameramove += cameraspeedincrease * accelerationc
	if $Player.velocity < velocitylimit:
		$Player.velocity +=velocityincrease * accelerationv
	if $itemtimer.wait_time > 0.5:
		$itemtimer.wait_time -= 0.05
	if $balltimer.wait_time > balltimelimit:
		$balltimer.wait_time -= 0.05 
	ProjectSettings.set_setting("rendering/environment/default_clear_color", Color(r,g,b))

	
	pass # replace with function body


func _on_changelevel_pressed():
	audio.get_node("click").play()
	
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	pass # replace with function body


func draw_curve():
	iteminfol1()
	var curveno = int (rand_range(0,9))
	var curve = utils.getcurve(str(curveno))
	if curve != null:
		$Camera2D/Path2D.set_curve(curve)
	var increament = $Camera2D/Path2D.curve.get_baked_length()/no
	$Camera2D/Path2D/PathFollow2D.offset = 0
	for i in range(0,no):
		var item =sitem.instance()
		
		add_child(item)
		if i == no - 1 :
			item.add_to_group("last")

		item.position = $Camera2D/Path2D/PathFollow2D.global_position
		$Camera2D/Path2D/PathFollow2D.offset += increament
		yield(utils.create_timer(0.01),"timeout")
		
	print("k")
	pass # replace with function body


func select_level():
	if utils.level == 1:
		loweritem = 0
		higheritem = 3
		lowerdrop = 0
		higherdrop = 1
		utils.gemno = 10
		r = 0
		g = 0
		b = 0.14
	if utils.level ==2:
		loweritem = 0
		higheritem = 3
		lowerdrop = 1
		higherdrop = 2
		utils.gemno = 12
		r = 0
		g = 0.24
		b = 0
	if utils.level == 3:
		loweritem = 0
		higheritem = 4
		lowerdrop = 0
		higherdrop = 2
		utils.gemno = 15
		r = 0.23
		g = 0.14
		b = 0
	if utils.level == 4:
		loweritem = 0
		higheritem = 4
		lowerdrop = 0
		higherdrop = 1
		utils.gemno = 20
		balltimelimit = 0.7
		r = 0
		g = 0.2
		b = 0.1
	if utils.level == 5:
		loweritem = 0
		higheritem = 4
		lowerdrop = 0
		higherdrop = 2
		utils.gemno = 20
		balltimelimit = 0.4
		r = 0.01
		g = 0
		b = 0.12
	var t = 60/utils.gemno
	ProjectSettings.set_setting("rendering/environment/default_clear_color", Color(r,g,b))
	$ui/CanvasLayer/HBoxContainer/Container/Label3.set_text(str(utils.gemno))
	$gemtimer.set_wait_time(t)


###      level 1-------------------
func iteminfol1():
	var choose = int(rand_range(loweritem,higheritem))
	if choose == 0:
		sitem = Square
		no = int(rand_range(5,7))
	if choose == 1:
		sitem = Rectangle
		no = int(rand_range(2,4))
	if choose == 2:
		sitem = Starblack
		no = int(rand_range(3,5))
	if choose == 3:
		sitem = Spike
		no = int(rand_range(1,2))

func dropinfo():
	var choose = int(rand_range(lowerdrop,higherdrop))
	if choose == 0:
		bitem = Ballg
	if choose == 1:
		bitem = Starb




func _on_balltimer_timeout():
	dropinfo()
	$Camera2D/ballpath/PathFollow2D.offset = randi()
	
	var ball = bitem.instance()
	add_child(ball)
	ball.position = $Camera2D/ballpath/PathFollow2D.global_position
	pass # replace with function body


func _on_gemtimer_timeout():
	gemtimeno += 1
	if gemtimeno >= utils.gemno:
		$gemtimer.stop()
	$Camera2D/gempath/PathFollow2D.offset = randi()
	var gem = Gem.instance()
	add_child(gem)
	gem.position = $Camera2D/gempath/PathFollow2D.global_position
	pass # replace with function body





func _on_AnimationPlayer_animation_finished(anim_name):
	var s = utils.loadfile()
	if anim_name == "New Anim" and s[starlevel] >= 2:
		$ui/CanvasLayer/Popuplevel/star/AnimationPlayer.play("New Anim (2)")
	if anim_name == "New Anim (2)" and s[starlevel] >= 3:
		$ui/CanvasLayer/Popuplevel/star/AnimationPlayer.play("New Anim (3)")
	pass # replace with function body
