extends Control

signal reload
signal end



var sscore = true
var pshield = 0
var pinvisible = 0
var plife = 0
var gcoin = 0
var scoin = 0
var life = 1
var score = 0
var increaselife = false
onready var icon = preload("res://image/iconpause.png")
onready var icon1 = preload("res://image/bicon.png")

func _ready():
	utils.connect("sgcoin",self,"gcoin_update")
	utils.connect("sscoin",self,"scoin_update")
	utils.connect("spshield",self,"pshield_update")
	utils.connect("splife",self,"plife_update")
	utils.connect("spinvisible",self,"pinvisible_update")
	utils.connect("life",self,"life_changed")
	utils.connect("stime",self,"score_changed")
	set_high_score()
	pass

func gcoin_update():
	gcoin += 1;
	$HBoxContainer2/HBoxContainer/Container/Label1.set_text(str(gcoin))
	
func scoin_update():
	
	scoin += 1;
	$HBoxContainer2/HBoxContainer2/Container/Label2.set_text(str(scoin))

func pshield_update():
	pshield += 1;
	$HBoxContainer2/HBoxContainer3/Container/Label3.set_text(str(pshield))
	
func pinvisible_update():
	pinvisible += 1;
	$HBoxContainer2/HBoxContainer4/Container/Label4.set_text(str(pinvisible))
	
func plife_update():
	plife += 1;
	$HBoxContainer2/HBoxContainer5/Container/Label5.set_text(str(plife))


func life_changed():
	audio.get_node("Lifeshow").play()
	if life > 0 and increaselife == false:
		life -= 1
		
		if life == 0:
			gameover()
	elif increaselife == true:
		if life >= 3:
			print("fll life")
		else:
			life += 1
			
	increaselife = false


func gameover():
	if plife > 0:
		plife -= 1
		$HBoxContainer2/HBoxContainer5/Container/Label5.set_text(str(plife))
		increaselife = true
		utils.emit_signal("life")
		$Sprite.show()
		yield(utils.create_timer(3),"timeout")
		$Sprite.hide()
		return
	audio.get_node("Gameover2").play()
	audio.get_node("Bg").stop()
	var hscore = int(loadvalue())
	if score > hscore:
		save(str(score))
	$Container.show()
	emit_signal("end")
	sscore = false
	print("game over")
 

func score_changed():
	$Timer.start()

func _on_Timer_timeout():
	score += 1
	var hscore = int(loadvalue())
	if score == hscore:
		print("new high score")
	var smin = score/60
	var ssec = score % 60
	if sscore:
		if smin < 10:
			$HBoxContainer6/Container/Label1.set_text("0" + str(smin)  )
		else:
			$HBoxContainer6/Container/Label1.set_text(str(smin)  )
		
		if ssec < 10:
			$HBoxContainer6/Container/Label3.set_text("0" + str(ssec)  )
		else:
			$HBoxContainer6/Container/Label3.set_text(str(ssec)  )
	
	






func _on_Pshield_button_down():
	$HBoxContainer2/HBoxContainer3/Container/Pshield.rect_scale = Vector2(1.2,1.2)
	if pshield > 0 and utils.haspower == false:
		pshield -= 1
		utils.emit_signal("pshield")
		$HBoxContainer2/HBoxContainer3/Container/Label3.set_text(str(pshield))




func _on_Pshield_button_up():
	$HBoxContainer2/HBoxContainer3/Container/Pshield.rect_scale = Vector2(1,1)


func _on_Pinvisible_button_down():
	$HBoxContainer2/HBoxContainer4/Container/Pinvisible.rect_scale = Vector2(1.2,1.2)
	if pinvisible > 0 and utils.haspower == false:
		pinvisible -= 1
		utils.emit_signal("pinvisible")
		$HBoxContainer2/HBoxContainer4/Container/Label4.set_text(str(pinvisible))



func _on_Pinvisible_button_up():
	$HBoxContainer2/HBoxContainer4/Container/Pinvisible.rect_scale = Vector2(1,1)


func _on_Plife_button_down():
	$HBoxContainer2/HBoxContainer5/Container/Plife.rect_scale = Vector2(1.2,1.2)
	if plife > 0 :
		plife -= 1
		print(plife)
		increaselife = true
		utils.emit_signal("life")
		$HBoxContainer2/HBoxContainer5/Container/Label5.set_text(str(plife))


func _on_Plife_button_up():
		$HBoxContainer2/HBoxContainer5/Container/Plife.rect_scale = Vector2(0.9,0.9)


func _on_Play_pressed():
	audio.get_node("Button").play()
	if $HBoxContainer2/HBoxContainer6/Container/Play.texture_normal == icon1:
		$HBoxContainer2/HBoxContainer6/Container/Play.texture_normal = icon
		audio.get_node("Bg").stop()
		get_tree().paused = true
		$HBoxContainer2/HBoxContainer6/Container/Play.set_pause_mode(PAUSE_MODE_PROCESS)
	else:
		$HBoxContainer2/HBoxContainer6/Container/Play.texture_normal = icon1
		get_tree().paused = false
		audio.get_node("Bg").play()
		
func save(content):
    var file = File.new()
    file.open("res://save_game.dat", file.WRITE)
    file.store_string(content)
    file.close()

func loadvalue():
    var file = File.new()
    file.open("res://save_game.dat", file.READ)
    var content = file.get_as_text()
    file.close()
    return content
	
	
func set_high_score():
	var hscore = int(loadvalue())
	var smin = hscore/60
	var ssec = hscore % 60
	if smin < 10:
		$HBoxContainer7/Container/Label1.set_text("0" + str(smin)  )
	else:
		$HBoxContainer7/Container/Label1.set_text(str(smin)  )
	
	if ssec < 10:
		$HBoxContainer7/Container/Label3.set_text("0" + str(ssec)  )
	else:
		$HBoxContainer7/Container/Label3.set_text(str(ssec)  )



func _on_TextureButton_pressed():
	audio.get_node("Button").play()
	emit_signal("reload")
	pass # replace with function body


func _on_TextureButton2_pressed():
	audio.get_node("Button").play()
	get_tree().change_scene("res://scenes/MainMenu.tscn")
	pass # replace with function body
