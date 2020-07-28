extends Node2D
export(PackedScene) var Fish
export(PackedScene) var Octo
export(PackedScene) var Arrow
export(PackedScene) var Gcoin
export(PackedScene) var Scoin
export(PackedScene) var Plife
export(PackedScene) var Pinvisible
export(PackedScene) var Pshield

var stime = 0
var accel= 0
var faccel= 0.05

func _ready():
	utils.sizex = $TextureRect.rect_size.x
	utils.sizey = $TextureRect.rect_size.y
	utils.connect("pshield",self,"power_up")
	randomize()


func _process(delta):
	$Player.position.x = clamp($Player.position.x,33,5184-33)
	$Player.position.y = clamp($Player.position.y,33 ,3456-33)
	pass



func _on_Start_timeout():
	new_game()
	audio.get_node("Bg").play()

func new_game():
	utils.emit_signal("stime")
	$Timer/Stime.start()
	$CanvasLayer/Node2D/AnimationPlayer.play("New Anim")
	Powerfirs()
	enemy_start()


func enemy_start():
	$Timer/Fish.start()
	$Timer/Octo.start()
	$Timer/Coin.start()
	$Timer/Power.start()
	


func _on_Fish_timeout():
	$Path2D/PathFollow2D.offset = randi()
	if $Path2D/PathFollow2D.position.x > $TextureRect.rect_size.x +29 or $Path2D/PathFollow2D.position.y  > $TextureRect.rect_size.y + 22:
		utils.fishflip = true
		
	else:
		utils.fishflip = false
	var fish = Fish.instance()
	add_child(fish)
	
	fish.position = $Path2D/PathFollow2D.position
	var direction = $Path2D/PathFollow2D.rotation
	direction += rand_range(0,deg2rad(70))
	fish.rotation = direction
	fish.dir = direction

	var fishscale = rand_range(0.3,1.2)
	fish.get_child(0).scale = Vector2(fishscale,fishscale)
	fish.get_child(1).scale = Vector2(fishscale,fishscale)
	fish.fishscale = fishscale

func _on_Octo_timeout():
	var octo = Octo.instance()
	add_child(octo)
	$Path2D/PathFollow2D.offset = randi()
	octo.position = $Path2D/PathFollow2D.position
	var direction = $Path2D/PathFollow2D.rotation
	direction += rand_range(0,PI/4)
	octo.dir = direction
	var octoscale = rand_range(0.8,1.4)
	octo.get_child(0).scale = Vector2(octoscale,octoscale)
	octo.get_child(1).scale = Vector2(octoscale,octoscale)
	octo.octoscale = octoscale




func _on_Arrow_timeout():
	var lenth = utils.sizey/10
	var prob = int(rand_range(0,2))
	var pos = 0
	if prob == 0:
		for i in range (0,10):
			var arrow = Arrow.instance()
			add_child(arrow)
			
			arrow.get_child(0).scale = Vector2(0.7,0.7)
			arrow.position.y = pos
			pos += lenth
	else:
		for i in range (0,10):
			var arrow = Arrow.instance()
			add_child(arrow)
			arrow.get_child(0).scale = Vector2(0.7,0.7)
			arrow.position.x = utils.sizex 
			arrow.get_child(0).flip_h = true
			arrow.position.y = pos
			arrow.velocity = Vector2(-20,0)
			pos += lenth
	audio.get_node("Arrow").play()
func power_up():
	utils.haspower = true
	$Player/Shield.show()
	$Player/Shield/CollisionShape2D.disabled = false
	audio.get_node("Powers").play()
	yield(utils.create_timer(25),"timeout")
	$Player/Shield.hide()
	$Player/Shield/CollisionShape2D.disabled = true
	utils.haspower = false
	

func Powerfirs():
	for i in range (0,2):
		var item
		var randx = int(rand_range(0,utils.sizex))
		var randy = int(rand_range(0,utils.sizey))
		var randc = int (rand_range(0,4))
		if randc == 0:
			item = Pshield.instance()
		elif randc == 1:
			item = Pinvisible.instance()
		else:
			item = Plife.instance()
		add_child(item)	
		item.scale = Vector2(0.6,0.6)
		item.position = Vector2(randx,randy)

func _on_Power_timeout():
	var item
	var randx = int(rand_range(0,utils.sizex))
	var randy = int(rand_range(0,utils.sizey))
	var randc = int (rand_range(0,4))
	if randc == 0:
		item = Pshield.instance()
	elif randc == 1:
		item = Pinvisible.instance()
	else:
		item = Plife.instance()
	add_child(item)
	
	item.scale = Vector2(0.6,0.6)
	item.position = Vector2(randx,randy)
	yield(utils.create_timer(5),"timeout")
	remove_child(item)
		

func _on_Coin_timeout():
	var coin
	var item = []
	for i in range (1,15):
		var randx = int(rand_range(0,utils.sizex))
		var randy = int(rand_range(0,utils.sizey))
		var randc = int (rand_range(0,4))
		if randc == 0:
			coin = Gcoin.instance()
		else:
			coin = Scoin.instance()
		add_child(coin)
		item.append(coin)
		coin.position = Vector2(randx,randy)
	yield(utils.create_timer(5),"timeout")
	for i in range(1,15):
		remove_child(item.pop_back())

func _on_Stime_timeout():
	stime += 1
	accel += 0.01
	if $Timer/Octo.wait_time > 1:
		$Timer/Octo.wait_time -= accel
	if $Timer/Arrow.wait_time > 8:
		$Timer/Arrow.wait_time -= accel
	if $Timer/Fish.wait_time > 0.2:
		$Timer/Fish.wait_time -= faccel
	if stime == 45 :
		$Timer/Arrow.start()



func _on_Control_reload():
	get_tree().reload_current_scene()
	$Player.show()
#	$Player/CollisionShape2D.disabled = true
	pass # replace with function body
