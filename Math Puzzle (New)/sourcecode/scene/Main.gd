extends Node2D

signal playerout

var curveno = 0
var no = 0
var schange = 0
var reduce = 0
var extralifetime = 10
#var firstprevious = false
var curtime = 0
var answer = 0

var select = 0
var oselect = 0
var starlevel= null 
var highscore = 0
var stargame = 0
var first = true
var choose = null
var gameend = false
var last = false
var anspressed = false
#var nextpressed = false
var settingpressed = false
var lifelinepressed = false


var earncoinpressed = false
var guidepressed = false
var answerpressed = false
#var showpressed = false
var lifelineno = 0
var oksetting = false
var timeremain = 0
#var qinlevel = 15
var timerout = false
#var line = 3
var gqno =0
var pallow = true

var answerstr= null
var qs1= null
var qs2= null
var ans = null
var guidemenu = false
var btnbig = Vector2(1.1,1.1)
var btnsmall = Vector2(1,1)
var btnbign = Vector2(0.55,0.55)
var btnsmalln = Vector2(0.5,0.5)
var btnbignn = Vector2(0.48,0.55)
var btnsmallnn = Vector2(0.46,0.5)
var q= null
#var arp = []
#var previous = false
var answerbox = 0
var lifelinecoin = 50
var qno = 0
var anscorrect = 0
var addplaceno= null 
var qmax = 0
#var lincrease = false
var gameadd = 0

#var wordno = 1
#var wordnolimit = 5
#var limit= null
#var a = [3,0,2,4,1]
#var ar = []
var arr = []
var ansr = [0,0,0,0]
#var randqno = 0
var randq= null
#var ring = [0,0,0,0,0,0,0,0,0]
#var sentenceno = 1
#var mode = false
var ringcolor = [0,0,0]
signal addinter
signal addinter1


onready var ui = preload("res://scene/ui.tscn")

onready var ring2 = preload("res://image/ring2.png")
onready var ring3 = preload("res://image/ring3.png")
onready var ring4 = preload("res://image/ring4.png")

onready var ring7 = preload("res://image/ring7.png")
onready var ring8 = preload("res://image/ring8.png")
onready var ring9 = preload("res://image/ring9.png")
export(PackedScene) var Ball






var choosearr = null

var gemp = 0
var canout = true

func _ready():
	
#
	print(utils.level)
	utils.connect("guideend", self, "_on_guideend")
	utils.connect("givelife", self, "_on_givelife")
	get_node("gamebtn/audience").set_opacity(utils.opaudience)
	get_node("gamebtn/5050").set_opacity(utils.op50)
	get_node("gamebtn/skip").set_opacity(utils.opskip)
	get_node("gamebtn/rateus").set_opacity(utils.opanswer)
	get_node("upper/scorebar/ProgressBar").set_value( 10+utils.score *4)
	get_node("upper/scorebar/Label1").set_text(str(utils.score))
	randomize()
#	utils.puzno = 54
	choosearr = int(rand_range(1,utils.lastq))
	update_coin()
	utils.helppressed = true
	settingpressed = true
#	utils.extralifegain = true
#	_on_Node2D_2_lifegain()
	gamestart()

	
	addplaceno = int(rand_range(1,4))
	

	
#
func _on_backretry_pressed():
	timerout = false
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("AnimationPlayer").play("New Anim")
	get_node("ui/CanvasLayer/Popupdied/AnimationPlayer1").play("animout")
	get_node("ansbox/q" + str(answer)+ "/pos/right").show()
	pass # replace with function body









func _on_cross_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	set_opacity(0.2)
	get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animout")
	get_node("ui/CanvasLayer/Popuprestart/AnimationPlayer").play("animin")

	pass # replace with function body



func _on_changelevel_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	yield(utils.create_timer(0.2),"timeout")
	get_node("ui/CanvasLayer/Popuplevel/nextok/changelevel").set_scale(Vector2(0.55,0.55))
	utils.coin -= utils.coinlimit
	update_coin()
	get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animout")
	level_change()
	yield(utils.create_timer(0.5),"timeout")
	utils.indirect = true
	get_tree().reload_current_scene()
	
	pass # replace with function body














func _on_Timer_timeout():
	
	curtime += 1
	var temptime = int(curtime)
	timeremain = utils.qtime - curtime/10
	if temptime % 10 == 0 :
		get_node("upper/uperpart2/Label").set_text(str(timeremain))
	
	get_node("upper/ProgressBar").set_value(get_node("upper/ProgressBar").get_value() - reduce)#(90/(utils.qtime*10)))

	if curtime == utils.qtime * 10: 
		
		get_node("Timer").stop()
		if utils.answerpressed:
			get_node("ui/CanvasLayer/answer/AnimationPlayer").play("animout")
		if lifelinepressed:
			_on_backlifeline_pressed()
		if settingpressed:
			get_node("ui/CanvasLayer/menuin/AnimationPlayer").play("animout")
			_on_backmain_pressed()
		if earncoinpressed:
			_on_backmenuearn_pressed()
			get_node("ui/CanvasLayer/popupearn/AnimationPlayer").play("animout")
		
		get_node("AnimationPlayer").play_backwards("New Anim")

		if utils.puzno >= 2 and utils.extralifepossible:
			CheckNConnection.check_timer.start()
			utils.extralifepossible = false
			get_node("AnimationPlayer").play_backwards("New Anim")
			get_node("ui/CanvasLayer/extralife/AnimationPlayer").play("animin")
			get_node("ui/CanvasLayer/extralife/AnimationPlayer 2").play("New Anim")
			get_node("ui/CanvasLayer/extralife/extralifetimer").start()
		else:
			gamemodelose()
			gameend()
	if timeremain >= 0 and timeremain <= 5 and temptime % 10 == 0:
		audio.get_node("SamplePlayer2D").play("times up")
	pass # replace with function body

func _on_btndone_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/Keyboard/HBoxContainer 2/btndone").set_scale(Vector2(1.1,1.1))
	if answer == int(get_node("ui/CanvasLayer/Label").get_text()):
		yield(utils.create_timer(0.5),"timeout")
		audio.get_node("SamplePlayer2D").play("winsound")
		get_node("Question").hide()
		get_node("ui/CanvasLayer/Label").hide()
		animout()
		get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animin")
		
		var s = utils.loadfile()
		if curtime < 0.5* utils.qtime:
			s[utils.level] = 3
		elif curtime < 0.7 * utils.qtime:
			s[utils.level] = 2
		else:
			s[utils.level] = 1
		starlevel = utils.level
		utils.save(s)
		get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer").play("New Anim")
		
		if utils.level >= utils.maxlevel:
			utils.level = 1
		else:
			utils.level += 1
	
		var p = utils.loadfile()
	
		
		var previous = p[0]
		if utils.level > previous:
			p[0] = utils.level
			utils.save(p)
		get_node("Timer").stop()
		yield(utils.create_timer(0.5),"timeout")
		print(p[starlevel])
		if  p[starlevel] >= 2:
			print("hii")
			get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer").play("New Anim (2)")
		yield(utils.create_timer(0.5),"timeout")
		if  p[starlevel] >= 3:
			print("hii")
			get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer").play("New Anim (3)")
	else:
		emit_signal("playerout")
		get_node("Question").hide()
		get_node("ui/CanvasLayer/Label").hide()

func animin():
	yield(utils.create_timer(1),"timeout")

	get_node("Timer").start()

#	audio.get_node("SamplePlayer2D").play("spshield")

	
	get_node("ansbox/q1/AnimationPlayer").play("New Anim")

	get_node("ansbox/q2/AnimationPlayer").play("New Anim")

	get_node("ansbox/q3/AnimationPlayer").play("New Anim")

	get_node("ansbox/q4/AnimationPlayer").play("New Anim")
	
	


func animout():
	get_node("qbox/AnimationPlayer").play_backwards("New Anim (2)")
	get_node("ansbox/q1/AnimationPlayer").play_backwards("New Anim")
	get_node("ansbox/q2/AnimationPlayer").play_backwards("New Anim")
	get_node("ansbox/q3/AnimationPlayer").play_backwards("New Anim")
	get_node("ansbox/q4/AnimationPlayer").play_backwards("New Anim")








func _on_back_pressedtouch():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Timer").stop()
	pass # replace with function body


func _on_AnimationPlayer_animation_started( name ):
	get_node("Question").hide()
	get_node("ui/CanvasLayer/Label").hide()
	pass # replace with function body



func _on_ui_qhide():
#	yield(utils.create_timer(0.5),"timeout")
	get_node("Question/AnimationPlayer").play_backwards("New Anim")
	
	pass # replace with function body


func _on_ui_qshow():
	yield(utils.create_timer(0.5),"timeout")
	get_node("Question/AnimationPlayer").play("New Anim")
	
	pass # replace with function body



func _on_retry_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	
	get_node("ui/CanvasLayer/Popuprestart/AnimationPlayer").play_backwards("animin")
	yield(utils.create_timer(0.5),"timeout")
	print("uuu")
	get_tree().reload_current_scene()
	pass # replace with function body












func _on_back2_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
#	anspressed = true
	get_node("ui/CanvasLayer/Popup2/AnimationPlayer").play("animout")
	_on_ui_qshow()
	get_node("Timer").start()
	pass # replace with function body
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		if utils.answerpressed:
			_on_ansback_pressed()
		elif lifelinepressed:
			_on_backlifeline_pressed()
		elif guidepressed:
			_on_guideback_pressed()
		elif timerout:
			_on_backretry_pressed()
			emit_signal("addinter")
		elif earncoinpressed:
			_on_backmenuearn_pressed()
			get_node("ui/CanvasLayer/popupearn/AnimationPlayer").play("animout")
		elif settingpressed and oksetting:
			get_node("ui/CanvasLayer/menuin/AnimationPlayer").play("animout")
			_on_backmain_pressed()
		else:
			utils.endgame()
			emit_signal("addinter")
			get_tree().change_scene_to(ui)





func _on_ConfirmationDialog_confirmed():
	get_tree().quit()
	pass # replace with function body


func _on_Node2D_answer():
	_on_Answerbtn_pressed()
	pass # replace with function body

func _on_setting_pressed():
	
	if !settingpressed:
		oksetting = true
		settingpressed = true
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("AnimationPlayer").play_backwards("New Anim")
		get_node("setting").set_scale(Vector2(0.35,0.35))
		get_node("ui/CanvasLayer/menuin/AnimationPlayer").play("animin")
		set_opacity(0.2)
		
	pass # replace with function body


func _on_setting_released():
	get_node("setting").set_scale(Vector2(0.3,0.3))
	pass # replace with function body

func update_coin():
	get_node("Coin/Label").set_text(str(utils.coin))
	get_node("ui/CanvasLayer/popupearn/Label1").set_text(str(utils.coin))
	var p = utils.loadfile()
	p[701] = utils.coin
	utils.save(p)
	


func _on_earncoin_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/Popup/earncoin").set_scale(Vector2(0.38,0.38))
	get_node("popupearn/AnimationPlayer").play("animin")
	pass # replace with function body


func _on_earncoin_released():
	get_node("ui/CanvasLayer/Popup/earncoin").set_scale(Vector2(0.35,0.35))
	pass # replace with function body


#func _on_Answerbtnfirst_pressed():
#	audio.get_node("SamplePlayer2D").play("hit")
#	get_node("ui/CanvasLayer/Answerbtn").set_scale(Vector2(0.38,0.38))
#	get_node("Popup/AnimationPlayer").play("animin")
#	pass # replace with function body
#
#
#func _on_Answerbtn_released():
#	get_node("ui/CanvasLayer/Answerbtn").set_scale(Vector2(0.35,0.35))
#	pass # replace with function body


func _on_backmain_pressed():
	oksetting = false
	audio.get_node("SamplePlayer2D").play("hit")
	settingpressed = false
	set_opacity(1)
	get_node("AnimationPlayer").play("New Anim")
	pass # replace with function body


func _on_btnq1_pressed():
	if not anspressed :
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("ansbox/q1").set_scale(btnbig)
		
		common()
		if answerbox != 1:
			get_node("ansbox/q1/pos/wrong").show()
			wrong_answer()
		else:
#			get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(true)
			
			get_node("Timerparticle").start()
			increase_coin()
			right_answer()
		get_node("ansbox/q" + str(answerbox)+ "/pos/right").show()
		anspressed = true
	pass # replace with function body


func _on_btnq1_released():
	get_node("ansbox/q1").set_scale(btnsmall)
	pass # replace with function body


func _on_btnq2_pressed():
	if not anspressed :
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("ansbox/q2").set_scale(btnbig)
		common()
		if answerbox != 2:
			get_node("ansbox/q2/pos/wrong").show()
			wrong_answer()
		else:
#			get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(true)
			get_node("Timerparticle").start()
			increase_coin()
			right_answer()
		get_node("ansbox/q" + str(answerbox)+ "/pos/right").show()
		anspressed = true
	pass # replace with function body


func _on_btnq2_released():
	get_node("ansbox/q2").set_scale(btnsmall)
	pass # replace with function body


func _on_btnq3_pressed():
	if not anspressed :
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("ansbox/q3").set_scale(btnbig)
		common()
		if answerbox != 3:
			get_node("ansbox/q3/pos/wrong").show()
			wrong_answer()
		else:
#			get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(true)
			get_node("Timerparticle").start()
			increase_coin()
			right_answer()
		get_node("ansbox/q" + str(answerbox)+ "/pos/right").show()
		anspressed = true
	pass # replace with function body


func _on_btnq3_released():
	get_node("ansbox/q3").set_scale(btnsmall)
	pass # replace with function body


func _on_btnq4_pressed():
	if not anspressed :
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("ansbox/q4").set_scale(btnbig)
		common()
		if answerbox != 4:
			get_node("ansbox/q4/pos/wrong").show()
			wrong_answer()
		else:
#			get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(true)
			get_node("Timerparticle").start()
			increase_coin()
			right_answer()
		get_node("ansbox/q" + str(answerbox)+ "/pos/right").show()
		anspressed = true
	pass # replace with function body


func _on_btnq4_released():
	get_node("ansbox/q4").set_scale(btnsmall)
	pass # replace with function body


func _on_Timerparticle_timeout():
	
	get_node("ansbox/q" + str(answerbox)+ "/coinparticle/Particles2D").set_emitting(false)
	get_node("ansbox/q" + str(answerbox)+ "/coinparticle/Particles2D1").set_emitting(false)
	yield(utils.create_timer(1),"timeout")
	get_node("Timercoin").stop()
	update_coin()
	pass # replace with function body
	
func increase_coin():
	var p = utils.loadfile()
	if get_node("ansbox/q" + str(answerbox)+ "/pos/right").is_visible() == false :
		increase_score()
		anscorrect += 1
		if utils.level > 0:
			print(timeremain)
			
			get_node("ansbox/q" + str(answerbox)+ "/coinparticle/Particles2D1").set_emitting(true)
			get_node("ansbox/q" + str(answerbox)+ "/coinparticle/Particles2D").set_emitting(true)
			var i = timeremain
			if curtime/10 > 60:
				get_node("Timercoin").set_wait_time(0.085)
			elif curtime/10 > 30:
				get_node("Timercoin").set_wait_time(0.075)
			else:
				get_node("Timercoin").set_wait_time(0.065)
			
			get_node("Timercoin").start()
			yield(utils.create_timer(1.5),"timeout")
			audio.get_node("SamplePlayer2D").play("coinget")
			yield(utils.create_timer(1),"timeout")
			audio.get_node("SamplePlayer2D").play("coinget")


func _on_Timercoin_timeout():
	utils.coin += 1
	
	get_node("Coin/Label").set_text(str(utils.coin))
	get_node("ui/CanvasLayer/popupearn/Label1").set_text(str(utils.coin))
	pass # replace with function body



	
func hidealltick():
	get_node("ansbox/q" + str(answerbox)+ "/pos/right").hide()
	get_node("ansbox/q4/pos/wrong").hide()
	get_node("ansbox/q3/pos/wrong").hide()
	get_node("ansbox/q2/pos/wrong").hide()
	get_node("ansbox/q1/pos/wrong").hide()

func common():
	utils.helppressed = true
	if qmax == qno:
		qmax += 1
	if utils.gamemode:
		get_node("down/next").set_opacity(1)
	get_node("Timer").stop()
	get_node("down/whatsapp/Label").show()


func _on_next_released():
	get_node("down/next").set_scale(Vector2(0.5,0.5))
	pass # replace with function body


func _on_earncoinnext_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/Popuplevel/notok/earncoinnext").set_scale(Vector2(0.55,0.55))
	get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animout")
	get_node("ui/CanvasLayer/popupearn/AnimationPlayer").play("animin")
	pass # replace with function body




	if !utils.helppressed and !utils.answerpressed:
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("gamebtn/rateus").set_scale(btnbign)
		lifelineno = 4
		commonlifeline()
		


func _on_rateus_released():
	get_node("gamebtn/rateus").set_scale(btnsmalln)
	pass # replace with function body


func _on_backmenuearn_pressed():
	if utils.gamemode:
		settingpressed = false
		earncoinpressed = false
		get_node("AnimationPlayer").play("New Anim")
	else:
		yield(utils.create_timer(0.5),"timeout")
		get_tree().reload_current_scene()
		utils.first_time = true
	pass # replace with function body


func _on_no_pressed():
	anspressed = false
	get_node("AnimationPlayer").play("New Anim")
	pass # replace with function body


func wrong_answer():
	audio.get_node("SamplePlayer2D").play("wrong1")
	yield(utils.create_timer(1),"timeout")
	if utils.gamemode:
		if utils.puzno >= 2 and utils.extralifepossible:
			CheckNConnection.check_timer.start()
			utils.extralifepossible = false
			get_node("AnimationPlayer").play_backwards("New Anim")
			get_node("ui/CanvasLayer/extralife/AnimationPlayer").play("animin")
			get_node("ui/CanvasLayer/extralife/AnimationPlayer 2").play("New Anim")
			get_node("ui/CanvasLayer/extralife/extralifetimer").start()
		else:
			gamemodelose()
			gameend()

		
	
func right_answer():
	yield(utils.create_timer(0.5),"timeout")
	audio.get_node("SamplePlayer2D").play("right")

	yield(utils.create_timer(2),"timeout")
	get_node("ansbox/q" + str(answerbox)+ "/coinparticle/Particles2D").set_emitting(false)
	get_node("ansbox/q" + str(answerbox)+ "/coinparticle/Particles2D1").set_emitting(false)
#	utils.level += 1
	
	utils.lastq -= 1
	utils.puzno += 1
	if utils.puzno == 54:
		utils.lastq = 55
		utils.setlevel()
	yield(utils.create_timer(1.6),"timeout")
	get_node("AnimationPlayer").play_backwards("New Anim")
	yield(utils.create_timer(0.31),"timeout")
	emit_signal("addinter")
#	get_node("ui/CanvasLayer/guide/AnimationPlayer").play("animin")
	get_tree().reload_current_scene()
#	gamestart()

func _on_home_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/menuin/home").set_scale(Vector2(0.44,0.44))
	utils.first_time = true
	yield(utils.create_timer(0.2),"timeout")
	get_tree().change_scene_to(ui)
	pass # replace with function body


func _on_Node2D_refresh():
	get_node("ui/CanvasLayer/popupearn/Tonextlevel").show()
	pass # replace with function body


func _on_share_refresh():
	get_node("ui/CanvasLayer/popupearn/Tonextlevel").show()
	pass # replace with function body


#func _on_Tonextlevel_pressed():
#	audio.get_node("SamplePlayer2D").play("hit")
#	if utils.coin >= utils.coinlimit :
#		utils.coin -= utils.coinlimit
#		level_change()
#		update_coin()
#		get_node("ui/CanvasLayer/popupearn/AnimationPlayer").play("animout")
#		
#		yield(utils.create_timer(0.5),"timeout")
#		get_tree().reload_current_scene()
#	else:
#		get_node("ui/CanvasLayer/popupearn/morecoin").show()
#		yield(utils.create_timer(2),"timeout")
#		get_node("ui/CanvasLayer/popupearn/morecoin").hide()
	

#func getq():
#	answer = int(rand_range(1,5))
#	var repeat = true
#	if utils.gamemode:
#		limit = 1000
#	else:
#		if utils.level<15:
#			limit = 200
#		else:
#			limit = (utils.level-1)*wordnolimit 
#	for i in range(0,4):
#		repeat = true
#		ansr[i] = int(rand_range(1,limit+6))
#		if i+1 == answer:
#				if qno%2 == 0 and qno < 10 and utils.learnmode and wordno >= 0 :
#					
#					if !previous and qno >= qmax:
#						firstprevious = false
#						ansr[i] = a[wordno]+1+(utils.level-1)*5
#						arp.append(ansr[i])
#						wordno -= 1
#					else:
#							ansr[i] = arp[qno]
#							previous = false
#				else:
#					 
#					if randqno == 0:
#						select = int(rand_range(1,limit))
#						ar.append(select)
#					else:
#						var interval = int(rand_range(6,20))
#						select = select + interval
#						if select> limit:
#							select = int(rand_range(1,limit))
#						
#						ar.append(select)
#						var n = 5
#						while repeat and n > 0:
#							var k = 0
#							ar[randqno] = int(rand_range(1,limit+1))
#							var m = 6
#							while ar[k]!=ar[randqno]:
#								k+=1
#							if k == randqno or randqno >= limit:
#								repeat = false
#							n -= 1
#					if !previous and qno >= qmax:
#						firstprevious = false
#						ansr[i] = ar[randqno]
#						arp.append(ansr[i])
#						randqno += 1
#					else:
#						ansr[i] = arp[qno]
#						previous = false
#		oselect = int(rand_range(1,limit))
#		var ointerval = int(rand_range(6,20))
#		i = 0
#		while i < 4:
#			if i+1 != answer:
#				if ansr[answer-1] != oselect: ##and ansr[answer-1] != oselect:
#					ansr[i] = oselect
#					i = i + 1
#					print("hh")
#			else:
#				i+=1
#			oselect = oselect+ointerval
#			if oselect >= limit:
#				oselect = int(rand_range(1,limit))
		
#		repeat = true
#		var n = 5
#		while repeat and n>0:
#			var j = 0
#			if i+1 != answer:
#				ansr[i] = int(rand_range(1,limit+6))
#			var m = 6
#			while ansr[j]!=ansr[i] and m>0:
#					j+=1
#					m-=1
#			if j == i:
#					repeat = false
#			n-=1
#	if utils.englishtohindi:
#		TranslationServer.set_locale("hi")
#		tr("hi")
#		for i in range(1,5):
#			get_node("ansbox/q" + str(i)+ "/Label").add_font_override("font",load("res://font/mangal.fnt"))
#	else:
#		TranslationServer.set_locale("en")
#		tr("en")
#		for i in range(1,5):
#			get_node("ansbox/q" + str(i)+ "/Label").add_font_override("font",load("res://lob1.fnt"))
#	
#	get_node("ansbox/q1/Label").set_text(tr("w" + str(ansr[0])))
#	get_node("ansbox/q2/Label").set_text(tr("w" + str(ansr[1])))
#	get_node("ansbox/q3/Label").set_text(tr("w" + str(ansr[2])))
#	get_node("ansbox/q4/Label").set_text(tr("w" + str(ansr[3])))
#	
#	if qno%2 == 0 and qno < 10 and utils.learnmode and wordno >= 0:
#		print("hii")
#		print(a[wordno]+1+(utils.level-1)*5)
#		get_node("ansbox/q" + str(answer)+ "/Label").set_text(tr( "w" + str(a[wordno]+1+(utils.level-1)*5)))
#		if utils.englishtohindi:
#			TranslationServer.set_locale("en")
#			tr("en")
#			get_node("qbox/Label").add_font_override("font",load("res://lob.fnt"))
#		else:
#			TranslationServer.set_locale("hi")
#			tr("hi")
#			
#			get_node("qbox/Label").add_font_override("font",load("res://font/mangal1.fnt"))
#		get_node("qbox/Label").set_text(tr( "w" + str(arp[qno])))
#		
#		
#	else:
#		repeat = true
#		ar.append(int(rand_range(1,limit+1)))
#		if randqno > 0:
#			while repeat:
#				var i = 0
#				ar[randqno] = int(rand_range(1,limit+1))
#				while ar[i]!=ar[randqno]:
#					i+=1
#				if i == randqno or randqno >= limit:
#					repeat = false
#		print(ar[randqno])
#		get_node("ansbox/q" + str(answer)+ "/Label").set_text(tr( "w" + str(ar[randqno])))

#		if utils.englishtohindi:
#			TranslationServer.set_locale("en")
#			tr("en")
#			get_node("qbox/Label").add_font_override("font",load("res://lob.fnt"))
#		else:
#			TranslationServer.set_locale("hi")
#			tr("hi")
#			get_node("qbox/Label").add_font_override("font",load("res://font/mangal1.fnt"))
#		get_node("qbox/Label").set_text(tr( "w" + str(arp[qno])))
#		
#		answerstr = utils.result[levelfactor + qno*line + 2]
	


func calllevelinfo():

		if utils.level == 201:
#			TranslationServer.set_locale("hi_IN")
#			tr("hi_IN")
	#		get_node("guide/Label").set_text(tr("gg1"))
			get_node("ui/CanvasLayer/guide/Label5").show()
			get_node("ui/CanvasLayer/guide/AnimationPlayer").play("animin")
		get_node("level/Label").set_text(str(utils.puzno))
		get_node("ui/CanvasLayer/levelinfo/level1").set_text(str(utils.puzno))
#		fillword()
#		audio.get_node("SamplePlayer2D").play("swap")
	#	get_node("AnimationPlayer").play_backwards("New Anim")
		get_node("ui/CanvasLayer/levelinfo/AnimationPlayer").play("animin")
		
		get_node("infotime").start()
		
	


func selectqs():
	qs1 = answerbox
	qs2 = answerbox
	while(qs2 == answerbox):
		qs2 = int(rand_range(1,5))
	print(qs1)
	print(qs2)


func _on_5050_pressed():
	if !utils.helppressed and !utils.fiftypressed:
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("gamebtn/5050").set_scale(btnbign)
		commonlifeline()
		lifelineno = 2
	pass # replace with function body


func showall():
	for i in range(1,5):
		if get_node("ansbox/q" + str(i)).is_visible() == false:
			get_node("ansbox/q" + str(i)).show()



func _on_audience_pressed():
	if !utils.helppressed and !utils.audiencepressed:
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("gamebtn/audience").set_scale(btnbign)
		commonlifeline()
		lifelineno = 1
#	get_node("ansbox/q4/percent/Label1"
	pass # replace with function body

func pecenthide():
	for i in range(1,5):
		get_node("ansbox/q" + str(i)+ "/percent/Label1").hide()
		get_node("ansbox/q" + str(i)+ "/percent/Label2").hide()





func increase_score():
		audio.get_node("SamplePlayer2D").play("swap")
		utils.score += 1
		get_node("upper/scorebar/ProgressBar").set_value( 10+utils.score *4)
		get_node("upper/scorebar/Label1").set_text(str(utils.score))

func select_game():
	
	var p = utils.loadfile()
	if p[713]:
		p[713] = false
		guidepressed = true
		get_node("ui/CanvasLayer/btnguide/AnimationPlayer").play("animin")
		utils.save(p)
	elif utils.retryq != null:
		select_level1()
	else:
		calllevelinfo()
	curtime = 0
	if not anspressed:
		get_node("down/next").set_opacity(0.7)
	
	gameadd += 1
	yield(utils.create_timer(0.5),"timeout")
	
	get_node("level/Label").set_text(str(utils.puzno))
#	getq()
	
	
	
	get_node("upper/ProgressBar").set_value(100)
	anspressed = false
	
#func nextbtngame():
#	if anspressed:
#		get_node("Timer").stop()
#		get_node("upper/uperpart2/Label").set_text(str(20))
#		showall()
#		pecenthide()
#		anspressed = false
#		
#		utils.helppressed = false
#		yield(utils.create_timer(0.1),"timeout")
#		qno += 1
#		utils.level += 1
#		if gameadd % 7 == 0:
#			emit_signal("addinter")
#		animout()
#		get_node("ansbox/q" + str(answerbox)+ "/coinparticle/Particles2D").set_emitting(false)
#		get_node("ansbox/q" + str(answerbox)+ "/coinparticle/Particles2D1").set_emitting(false)
#		get_node("down/whatsapp/Label").hide()
#		
#		audio.get_node("SamplePlayer2D").play("hit")
#		get_node("down/next").set_scale(Vector2(0.55,0.55))
#		select_game()
#	#	if qno == qinlevel and !nextpressed:
#	#		nextpressed = true
#	#		sbox/q" + str(answer)+ "/pos/right").show()
	
#func nextbtnlearn():
#	if not nextpressed:
#		nextpressed = true
#		hidealltick()
#		get_node("Timer").stop()
#		get_node("upper/uperpart2/Label").set_text(str(20))
#		qno += 1
#		if qno > qmax:
#			qmax = qno
#		
#		utils.helppressed = false
#		get_node("nexttime").start()
#		yield(utils.create_timer(0.1),"timeout")
#		
#	
#		
#		if qno == 9:
#			emit_signal("addinter")
#		animout()
#		get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(false)
#		get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D1").set_emitting(false)
#		get_node("down/whatsapp/Label").hide()
#		
#		audio.get_node("SamplePlayer2D").play("hit")
#		get_node("down/next").set_scale(Vector2(0.55,0.55))
#		if qno == qinlevel and !last:
#			last = true
#	#		settingpressed = true
#			var s = utils.loadfile()
#			get_node("ui/CanvasLayer/Popuplevel/Sprite/gain").set_text(str(anscorrect))
#			if utils.level == s[0]:
#				if utils.coin >= utils.coinlimit:
#					get_node("ui/CanvasLayer/Popuplevel/nextok").show()
#				else:
#					get_node("ui/CanvasLayer/Popuplevel/notok").show()
#			else:
#				get_node("ui/CanvasLayer/Popuplevel/tempok").show()
#			audio.get_node("SamplePlayer2D").play("winsound")
#			get_node("AnimationPlayer").play_backwards("New Anim")
#			anspressed = true
#			get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animin")
#			yield(utils.create_timer(0.5),"timeout")
#			
#			if anscorrect > qinlevel * 0.8:
#				s[utils.level] = 3
#				get_node("ui/CanvasLayer/Popuplevel/Labelgreet").set_text("Excellent")
#			elif anscorrect > qinlevel * 0.4:
#				s[utils.level] = 2
#				get_node("ui/CanvasLayer/Popuplevel/Labelgreet").set_text("Good")
#			else:
#				s[utils.level] = 1
#				get_node("ui/CanvasLayer/Popuplevel/Labelgreet").set_text("Poor")
#			starlevel = utils.level
#			utils.save(s)
#			get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer").play("New Anim")
#			get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer 2").play("New Anim")
#			
#			
#			
#			
#		
#	#		get_tree().set_pause(true)
#	#		get_node("ui/CanvasLayer/Popuplevel").set_pause_mode(Node.PAUSE_MODE_PROCESS)
#			yield(utils.create_timer(0.5),"timeout")
#			print(s[starlevel])
#			if  s[starlevel] >= 2:
#				print("hii")
#				get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer").play("New Anim (2)")
#			yield(utils.create_timer(0.5),"timeout")
#			if  s[starlevel] >= 3:
#				print("hii")
#				get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer").play("New Anim (3)")
#			
#		elif qno < qinlevel:
#			select_level()
#			if qno < qmax:
#				yield(utils.create_timer(1.5),"timeout")
#				get_node("ansbox/q" + str(answer)+ "/pos/right").show()
#	

func _on_retrygame_pressed():
	yield(utils.create_timer(0.2),"timeout")
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/gameend/retrygame").set_scale(Vector2(0.55,0.55))
	get_node("ui/CanvasLayer/gameend/AnimationPlayer1").play("animout")
	yield(utils.create_timer(0.5),"timeout")
	utils.indirect = true
	emit_signal("addinter")
	get_tree().reload_current_scene()
	pass # replace with function body


func _on_skip_pressed():
	if !utils.helppressed and !utils.skippressed:
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("gamebtn/skip").set_scale(btnbign)
		commonlifeline()
		lifelineno = 3
	pass # replace with function body


func _on_paycoin_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/lifeline/ok/paycoin").set_scale(Vector2(0.55,0.55))
	utils.coin -= lifelinecoin
	update_coin()
	get_node("ui/CanvasLayer/lifeline/AnimationPlayer1").play("animout")
	
	if lifelineno == 1:
		get_node("AnimationPlayer").play("New Anim")
		yield(utils.create_timer(0.5),"timeout")
		audience()
	elif lifelineno == 2:
		get_node("AnimationPlayer").play("New Anim")
		yield(utils.create_timer(0.5),"timeout")
		fifty50()
	elif lifelineno == 3:
		skip()
	elif lifelineno == 4:
		answer()
	pass # replace with function body

func audience():
		utils.audiencepressed = true
		utils.opaudience = 0.7
		get_node("gamebtn/audience").set_opacity(utils.opaudience)
		utils.lifeline -= 1
		print("hellol")
		var percent = 100
		var arr = []
		arr = [1,2] 
		var third = 0
		var q1p = int(rand_range(30,41))
		percent -= q1p
		var q2p = int(rand_range(25,36))
		percent -= q2p
		arr[0] = int(rand_range(15,21))
		percent -= arr[0]
		arr[1] = percent
		var secondq = answerbox
		while(secondq == answerbox):
			secondq = int(rand_range(1,5))
		for i in range(1,5):
			if i == answerbox:
				get_node("ansbox/q" + str(i)+ "/percent/Label1").set_text(str(q1p))
			elif i == secondq:
				get_node("ansbox/q" + str(i)+ "/percent/Label1").set_text(str(q2p))
			else:
				get_node("ansbox/q" + str(i)+ "/percent/Label1").set_text(str(arr[third]))
				third += 1
			get_node("ansbox/q" + str(i)+ "/percent/Label1").show()
			get_node("ansbox/q" + str(i)+ "/percent/Label2").show()
			utils.helppressed = true


func _on_earncoingame_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	earncoinpressed = true
#	settingpressed = false
	lifelinepressed = false
	get_node("ui/CanvasLayer/lifeline/notok1/earncoingame").set_scale(Vector2(0.55,0.55))
	get_node("ui/CanvasLayer/lifeline/AnimationPlayer1").play("animout")
	get_node("ui/CanvasLayer/popupearn/AnimationPlayer").play("animin")
	pass # replace with function body


func _on_backlifeline_pressed():
	settingpressed = false
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("AnimationPlayer").play("New Anim")
	get_node("ui/CanvasLayer/lifeline/AnimationPlayer1").play("animout")
	lifelinepressed = false
	CheckNConnection.check_timer.stop()
	pass # replace with function body

func gameend():
#	if utils.gamemode:
		get_node("AnimationPlayer").play_backwards("New Anim")
		get_node("ui/CanvasLayer/gameend/AnimationPlayer1").play("animin")
		audio.get_node("SamplePlayer2D").play("game over")
#		utils.retryq = utils.level
		
		var s = utils.loadfile()
		highscore = s[702]
		if utils.score > highscore:
			highscore = utils.score 
			s[702] = utils.score
		
		get_node("ui/CanvasLayer/gameend/score/current/Sprite/Label").set_text(str(utils.score))
		get_node("ui/CanvasLayer/gameend/score/high/Sprite/Label").set_text(str(highscore))
#		audio.get_node("SamplePlayer2D").play("times up")
		utils.save(s)
		
		anspressed = true
		
		yield(utils.create_timer(0.5),"timeout")
		
		if utils.score > 10:
			stargame = 3
			get_node("ui/CanvasLayer/gameend/Labelgreet1").set_text("Excellent")
		elif utils.score > 7:
			stargame = 2
			get_node("ui/CanvasLayer/gameend/Labelgreet1").set_text("Good")
		elif utils.score > 3:
			stargame = 1
			get_node("ui/CanvasLayer/gameend/Labelgreet1").set_text("Not Bad")
		else:
			stargame = 1
			get_node("ui/CanvasLayer/gameend/Labelgreet1").set_text("Poor")
		
		
		get_node("ui/CanvasLayer/gameend/AnimationPlayer").play("New Anim")
		get_node("ui/CanvasLayer/gameend/AnimationPlayer 2").play("New Anim")
		
		yield(utils.create_timer(0.5),"timeout")
		if  stargame >= 2:
			print("hii")
			get_node("ui/CanvasLayer/gameend/AnimationPlayer").play("New Anim (2)")
		yield(utils.create_timer(0.5),"timeout")
		if  stargame >= 3:
			print("hii")
			get_node("ui/CanvasLayer/gameend/AnimationPlayer").play("New Anim (3)")
		utils.endgame()

func gamestart():
#	if !utils.network_error:
#		oksetting = true
		utils.gamemode = true
#		hidealltick()
#		utils.learnmode = false
		
#		get_node("down/previous").set_opacity(0.7)
#		get_node("gamebtn").show()
		
#		audio.get_node("SamplePlayer2D").play("start1")
		audio.get_node("SamplePlayer2D").play("spshield")
		select_game()
#	else:
#		get_node("ui/CanvasLayer/networkerror").show()

func set_lifeline():
	get_node("ui/CanvasLayer/lifeline/coin/Sprite/Label").set_text(str(utils.coin))
	get_node("ui/CanvasLayer/lifeline/liferemain/Sprite/Label").set_text(str(utils.lifeline))
#	get_node("ui/CanvasLayer/lifeline/liferemain/Sprite/Label").add_color_override("font_color", Color())
func commonlifeline():
		CheckNConnection.check_timer.start()
		lifelinepressed = true
		settingpressed = true
		set_lifeline()
		if utils.coin >= lifelinecoin:
			get_node("ui/CanvasLayer/lifeline/ok").show()
			get_node("ui/CanvasLayer/lifeline/notok1").hide()
		else:
			get_node("ui/CanvasLayer/lifeline/notok1").show()
			get_node("ui/CanvasLayer/lifeline/ok").hide()
		if utils.lifeline == 0:
			get_node("ui/CanvasLayer/lifeline/notok1").hide()
			get_node("ui/CanvasLayer/lifeline/ok").hide()
		get_node("AnimationPlayer").play_backwards("New Anim")
		get_node("ui/CanvasLayer/lifeline/AnimationPlayer1").play("animin")
		
func fifty50():
	utils.fiftypressed = true
	utils.op50 = 0.7
	get_node("gamebtn/5050").set_opacity(utils.op50)
	utils.lifeline -= 1
	selectqs()
	yield(utils.create_timer(0.5),"timeout")
	get_node("ansbox/q1").hide()
	get_node("ansbox/q2").hide()
	get_node("ansbox/q3").hide()
	get_node("ansbox/q4").hide()
	
	get_node("ansbox/q" + str(answerbox)).show()
	get_node("ansbox/q" + str(qs2)).show()
	utils.helppressed = true

func skip():
	utils.skippressed = true
	utils.opskip = 0.7
	get_node("gamebtn/skip").set_opacity(utils.opskip)
	utils.lifeline -= 1
	anspressed = true
	get_node("down/next").set_opacity(1)
	utils.helppressed = true
#	utils.level += 1
	utils.puzno += 1
	if utils.puzno == 54:
		utils.lastq = 55
		utils.setlevel()
	utils.arr.remove(utils.level)
#	yield(utils.create_timer(1.6),"timeout")
	get_node("AnimationPlayer").play_backwards("New Anim")
	yield(utils.create_timer(0.5),"timeout")
	utils.lastq -= 1
	utils.arr.remove(utils.level)
	get_tree().reload_current_scene()

func _on_backtouifromgame_pressed():
	
	yield(utils.create_timer(0.2),"timeout")
	utils.first_time = true
	get_node("ui/CanvasLayer/gameend/backtoui").set_scale(Vector2(0.44,0.44))
	get_node("ui/CanvasLayer/gameend/AnimationPlayer1").play("animout")
	yield(utils.create_timer(0.5),"timeout")
	emit_signal("addinter")
	get_tree().change_scene_to(ui)
	pass # replace with function body





func _on_audience_released():
	get_node("gamebtn/audience").set_scale(btnsmalln)
	pass # replace with function body


func _on_5050_released():
	
	get_node("gamebtn/5050").set_scale(btnsmalln)
	pass # replace with function body


func _on_skip_released():
	
	get_node("gamebtn/skip").set_scale(btnsmalln)
	pass # replace with function body


func _on_changelevel_released():
	get_node("ui/CanvasLayer/Popuplevel/nextok/changelevel").set_scale(Vector2(0.5,0.5))
	pass # replace with function body


func _on_earncoinnext_released():
	get_node("ui/CanvasLayer/Popuplevel/notok/earncoinnext").set_scale(Vector2(0.5,0.5))
	pass # replace with function body


func _on_retrygame_released():
	get_node("ui/CanvasLayer/gameend/retrygame").set_scale(Vector2(0.5,0.5))
	pass # replace with function body


func _on_backtoui_released():
	get_node("ui/CanvasLayer/gameend/backtoui").set_scale(Vector2(0.4,0.4))
	pass # replace with function body


func _on_earncoingame_released():
	get_node("ui/CanvasLayer/lifeline/notok1/earncoingame").set_scale(Vector2(0.5,0.5))
	pass # replace with function body


func _on_paycoin_released():
	get_node("ui/CanvasLayer/lifeline/ok/paycoin").set_scale(Vector2(0.5,0.5))
	pass # replace with function body





func _on_changeleveltemp_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	yield(utils.create_timer(0.2),"timeout")
#	get_node("ui/CanvasLayer/Popuplevel/nextok/changelevel").set_scale(Vector2(0.44,0.44))
#	utils.coin -= utils.coinlimit
#	update_coin()
	get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animout")
#	level_change()
	utils.level += 1
	yield(utils.create_timer(0.5),"timeout")
	utils.indirect = true
	get_tree().reload_current_scene()
	pass # replace with function body
	
func gamemodelose():
	gameend = true
#	settingpressed = true
#	utils.audiencepressed = true
#	utils.fiftypressed = true
#	utils.skippressed = true


func _on_nexttime_timeout():
#	nextpressed = false
	pass # replace with function body



func _on_Button_pressed():
	if !utils.network_error:
		get_node("ui/CanvasLayer/networkerror").hide()
		audio.get_node("SamplePlayer2D").play("spshield")
#		get_node("ui/CanvasLayer/mode").show()
#		get_node("AnimationPlayer").play("New Anim")
#		get_node("ui/CanvasLayer/mode").show()
#		get_node("ui/CanvasLayer/mode/AnimationPlayer").play("animin")
		gamestart()
	pass # replace with function body
	
func _on_guideend():
	if utils.guideno == 707 or utils.guideno == 710:
		calllevelinfo()
	if utils.guideno == 709:
		gamestart()
	if utils.guideno == 708:
		callsentencemode()




func _on_extralifetimer_timeout():
	extralifetime -= 1
	get_node("ui/CanvasLayer/extralife/ltime/Label1").set_text(str(extralifetime))
	if extralifetime <= 0:
		endextralife()
	pass # replace with function body

func endextralife():
		get_node("ui/CanvasLayer/extralife/extralifetimer").stop()
		get_node("ui/CanvasLayer/extralife/AnimationPlayer 2").stop(true)
		get_node("ui/CanvasLayer/extralife/AnimationPlayer").play("animout")
		CheckNConnection.check_timer.stop()
		gamemodelose()
		gameend()





func _on_Node2D_2_lifegain():
	print("100000")
	get_node("ui/CanvasLayer/extralife/extralifetimer").stop()
	get_node("ui/CanvasLayer/extralife/AnimationPlayer 2").stop(true)
	if utils.extralifegain:
		utils.extralifegain = false
		CheckNConnection.check_timer.stop()
		utils.retryq = utils.level
		utils.chooseball = choose
#		get_node("ui/CanvasLayer/extralife/AnimationPlayer").play("animout")
#		get_node("AnimationPlayer").play("New Anim")
		
		get_tree().reload_current_scene()
	else:
		get_node("ui/CanvasLayer/extralife/AnimationPlayer").play("animout")
		gamemodelose()
		gameend()
	pass # replace with function body

func select_level1():
	settingpressed = false
	utils.level = utils.arr[choosearr] 
	print(utils.level)
	print(utils.lastq)
	get_node("AnimationPlayer").play("New Anim")
	if utils.retryq != null:
		utils.level = utils.retryq
		yield(utils.create_timer(0.1),"timeout")
		get_node("Particles2D").set_emitting(true)
#		audio.get_node("SamplePlayer2D").play("spshield")
		yield(utils.create_timer(1),"timeout")
		get_node("Particles2D").set_emitting(false)
		yield(utils.create_timer(0.5),"timeout")
#		utils.retryq = null
#	utils.level = 54
	if utils.level == 3:
		utils.qtime = 60
#		get_node("Question/Label").set_text("Complete the puzzle with correct number :")
		answer = 9
		curveno = 3
		no = 4
		arr = [4,9,7,12,1,4,1,4,2,5,6,0]
	if utils.level ==2:
		utils.qtime = 60
		answer = 19
		curveno = 1
		no = 6
		arr = [5,7,11,13,17,0]
	if utils.level == 1:
		utils.qtime = 60
		answer = 16
		curveno = 1
		no = 9
		arr = [0,25,36,49,64,81,1,4,9]
	if utils.level == 4:
		utils.qtime = 60
		answer = 39
		curveno = 1
		no = 6
		arr = [3,5,8,13,22,0]
	if utils.level == 5:
		utils.qtime = 60
		answer = 4
		curveno = 1
		no = 16
		arr = [7,3,6,2,4,5,8,2,1,1,2,4,0,1,2,4]
	if utils.level == 6:
		utils.qtime = 55
		answer = 6
		curveno = 1
		no = 9
		arr = [9,1,5,3,7,0,2,4,8]
	if utils.level == 7:
		utils.qtime = 55
		answer = 40
		curveno = 1
		no = 5
		arr = [26,28,31,35,0]
	if utils.level == 8:
		utils.qtime = 55
		answer = 16
		curveno = 1
		no = 10
		arr = [16,2,15,4,13,7,10,11,6,0]
	if utils.level == 9:
		utils.qtime = 55
		answer = 7
		curveno = 1
		no = 7
		arr = [9,8,4,0,6,2,2]
	if utils.level == 10:
		utils.qtime = 55
		answer = 13
		curveno = 4
		no = 6
		arr = [9,11,13,15,17,7,7,10,13,16,19,4,11,16,21,26,31,6,5,9,0,17,21,1]
	if utils.level == 11:
		utils.qtime = 50
		answer = 3
		curveno = 4
		no = 3
		arr = [7,3,5,8,6,7,2,10,6,4,2,0]
	if utils.level == 12:
		utils.qtime = 50
		answer = 1
		curveno = 1
		no = 9
		arr = [2,8,9,4,0,6,3,3,2]
	if utils.level == 13:
		utils.qtime = 50
		answer = 1
		curveno = 1
		no = 8
		arr = [3,6,4,9,4,6,8,0]
	if utils.level == 14:
		utils.qtime = 50
		answer = 4
		curveno = 1
		no = 9
		arr = [5,8,11,12,14,10,7,3,0]
	if utils.level == 15:
		utils.qtime = 50
		answer = 253
		curveno = 1
		no = 7
		arr = [1,5,13,29,0,125,61,29]
	if utils.level == 16:
		utils.qtime = 45
		answer = 51
		curveno = 1
		no = 5
		arr = [6,9,15,27,0]
	if utils.level == 17:
		utils.qtime = 45
		answer = 2 
		curveno = 1
		no = 9
		arr = [10,8,13,6,16,4,19,0,22]
	if utils.level == 18:
		utils.qtime = 45
		answer = 6 
		curveno = 1
		no = 9
		arr = [3,1,4,9,2,7,1,5,0]
	if utils.level == 19:
		utils.qtime = 45
		answer = 10
		curveno = 3
		no = 6
		arr = [2,7,1,3,4,9,3,5,2,4,3,5,9,2,3,4,6,0]
		schange = 0.6
	if utils.level == 20:
		utils.qtime = 45
		answer = 23
		curveno = 1
		no = 9
		arr = [2,7,17,19,11,3,5,13,0]
	if utils.level == 21:
		utils.qtime = 40
		answer = 10
		curveno = 3
		no = 6
		arr = [11,9,2,6,1,4,10,5,7,0,1,10,1,4,9,1,2,14]
	if utils.level == 22:
		utils.qtime = 40
		answer = 1143
		curveno = 1
		no = 6
		arr = [195,383,575,763,955,0]
	if utils.level == 23:
		utils.qtime = 40
		answer = 6
		curveno = 4
		no = 4
		arr = [1,3,7,2,6,5,1,6,5,2,0,4,7,8,8,8]
	if utils.level == 24:
		utils.qtime = 40
		answer = 4
		curveno = 3
		no = 4
		arr = [1,4,3,4,7,6,7,10,3,0,5,6]
	if utils.level == 25:
		utils.qtime = 40
		answer = 4
		curveno = 3
		no = 6
		arr = [1,6,2,3,4,8,4,9,8,2,11,6,10,7,5,5,2,0]
		schange = 0.6
	if utils.level == 26:
		utils.qtime = 40
		answer = 5
		curveno = 3
		no = 3
		arr = [5,3,7,6,10,2,5,0,5]
	if utils.level == 27:
		utils.qtime = 40
		answer = 22
		curveno = 3
		no = 3
		arr = [3,7,18,2,8,12,3,9,0]
	if utils.level == 28:
		utils.qtime = 40
		answer = 4
		curveno = 4
		no = 4
		arr = [10,1,6,3,14,9,1,4,7,1,4,2,12,3,0,5]
	if utils.level == 29:
		utils.qtime = 40
		answer = 5
		curveno = 4
		no = 7
		arr = [9,2,1,4,7,3,2,6,3,8,4,5,1,7,8,7,3,6,2,9,1,5,1,3,2,8,4,0]
	if utils.level == 30:
		utils.qtime = 40
		answer = 7
		curveno = 1
		no = 15
		arr = [1,7,9,3,6,3,5,4,2,5,7,2,2,6,0]
	if utils.level == 31:
		utils.qtime = 35
		answer = 22
		curveno = 5
		no = 5
		arr = [4,6,2,1,12,3,5,11,7,9,8,12,0,14,24,7,11,13,8,21,1,1,9,6,3]
	if utils.level == 32:
		utils.qtime = 35
		answer = 21
		curveno = 1
		no = 5
		arr = [1,5,9,15,0]
	if utils.level == 33:
		utils.qtime = 35
		answer = 6
		curveno = 5
		no = 4
		arr = [4,9,3,12,7,13,6,12,5,9,3,2,7,8,5,21,0,16,5,12]
	if utils.level == 34:
		utils.qtime = 35
		answer = 7
		curveno = 4
		no = 5
		arr = [3,12,6,15,18,2,7,5,9,12,11,4,8,15,12,8,3,4,11,0]
	
	if utils.level == 35:
		utils.qtime = 35
		answer = 96
		curveno = 1
		no = 5
		arr = [32,45,60,77,0]
	if utils.level == 36:
		utils.qtime = 35
		answer = 9
		curveno = 1
		no = 10
		arr = [3,5,1,4,4,7,3,5,5,0]
	if utils.level == 37:
		utils.qtime = 35
		answer = 3
		curveno = 1
		no = 9
		arr = [1,2,3,4,1,2,5,6,0]
	if utils.level == 38:
		utils.qtime = 35
		answer = 13
		curveno = 3
		no = 6
		arr = [7,3,6,9,2,17,5,2,4,10,6,11,9,4,6,7,5,0]
	if utils.level == 39:
		utils.qtime = 35
		answer = 6
		curveno = 3
		no = 6
		arr = [14,4,8,7,2,4,6,2,12,3,1,6,12,4,10,0,2,5]
	if utils.level == 40:
		utils.qtime = 35
		answer = 1
		curveno = 4
		no = 4
		arr = [7,2,9,5,3,10,7,13,6,1,5,7,4,5,0,9]
	if utils.level == 41:
		utils.qtime = 30
		answer = 9
		curveno = 3
		no = 3
		arr = [5,2,3,6,10,4,6,0,15]
	if utils.level == 42:
		utils.qtime = 30
		answer = 26
		curveno = 1
		no = 10
		arr = [8,12,15,17,21,24,0,30,33,35]
	if utils.level == 43:
		utils.qtime = 30
		answer = 4
		curveno = 3
		no = 4
		arr = [1,7,3,22,9,2,6,21,3,8,5,0]
	
	if utils.level == 44:
		utils.qtime = 30
		answer = 6
		curveno = 5
		no = 4
		arr = [3,1,7,2,6,5,2,2,3,7,4,1,9,6,9,4,9,12,0,3]
	if utils.level == 45:
		utils.qtime = 30
		answer = 10
		curveno = 3
		no = 3
		arr = [7,6,3,2,4,1,9,0,4]
	if utils.level == 46:
		utils.qtime = 30
		answer = 37
		curveno = 1
		no = 6
		arr = [72,69,64,57,48,0]
	if utils.level == 47:
		utils.qtime = 30
		answer = 11
		curveno = 1
		no = 9
		arr = [9,20,2,0,15,7,4,13,5]
	if utils.level == 48:
		utils.qtime = 30
		answer = 42
		curveno = 1
		no = 7
		arr = [2,4,6,0,26,16,10]
	if utils.level == 49:
		utils.qtime = 30
		answer = 3
		curveno = 1
		no = 9
		arr = [5,4,7,6,6,12,7,0,2]
	if utils.level == 50:
		utils.qtime = 30
		answer = 42
		curveno = 1
		no = 10
		arr = [5,7,3,2,8,5,9,6,4,0]
	if utils.level == 51:
		utils.qtime = 25
		answer = 2
		curveno = 4
		no = 3
		arr = [3,4,1,10,12,8,2,2,5,5,6,0]
	if utils.level == 52:
		utils.qtime = 25
		answer = 13
		curveno = 1
		no = 9
		arr = [5,8,11,10,9,4,7,6,0]
	if utils.level == 53:
		utils.qtime = 25
		answer = 90
		curveno = 1
		no = 6
		arr = [23,38,45,64,67,0]
	if utils.level == 54:
		utils.qtime = 25
		answer = 3
		curveno = 1
		no = 9
		arr = [5,4,1,2,2,6,3,4,0]
#	get_node("Timer").start()
	utils.qtime = 90
	reduce = (utils.qtime * 10.0)
	reduce = (100.0/reduce)
	print(reduce)
	
	
	draw_curve()
	animin()
	getanswer()
#	get_node("ui/CanvasLayer/Popup2/Container/Label4").set_text(":  " + str(answer))  
#	ProjectSettings.set_setting("rendering/environment/default_clear_color", Color(r,g,b))
#	get_node("ui/CanvasLayer/Clock/Label").set_text("0" + str(utils.qtime/60) +":00")
func draw_curve():
	
	audio.get_node("SamplePlayer2D").play("spshield")
	choose = int(rand_range(0,6))
	var waittime = rand_range(0.1,0.3)
	if utils.retryq != null:
		choose = utils.chooseball
		utils.retryq = null
#	choose = 4
	var ball 
	
	if choose == 0:
		ball = ring2
		ringcolor = [0.5,0.43,0.03]
	elif choose == 1:
		ball = ring3
		ringcolor = [0.21,0.16,0.01]
	elif choose == 2:
		ball = ring4
		ringcolor = [0.01,0.3,0.08]
	elif choose == 3:
		ball = ring7
		ringcolor = [0.3,0.13,0.01]
	elif choose == 4:
		ball = ring8
		ringcolor = [0.01,0.3,0.08]
	elif choose == 5:
		ball = ring9
		ringcolor = [0.5,0.43,0.03]
	
	
	var cur = utils.level
	var curve = utils.getcurve(str(cur))
	if schange > 0:
		get_node("Question/Path2D0").set_scale(Vector2(schange,schange))
		get_node("Question/Path2D1").set_scale(Vector2(schange,schange))
		get_node("Question/Path2D2").set_scale(Vector2(schange,schange))
		get_node("Question/Path2D3").set_scale(Vector2(schange,schange))
	if curveno == 1:
		get_node("Question/Path2D0").set_global_pos(get_node("Question/Container/mid").get_global_pos())
	if curveno == 2:
		get_node("Question/Path2D0").set_global_pos(get_node("Question/Container/tmid").get_global_pos())
		get_node("Question/Path2D1").set_global_pos(get_node("Question/Container/bmid").get_global_pos())
	if curveno == 3:
		get_node("Question/Path2D0").set_global_pos(get_node("Question/Container/left").get_global_pos())
		get_node("Question/Path2D1").set_global_pos(get_node("Question/Container/right").get_global_pos())
		get_node("Question/Path2D2").set_global_pos(get_node("Question/Container/bmid").get_global_pos())
	if curveno == 4:
		get_node("Question/Path2D0").set_global_pos(get_node("Question/Container/left").get_global_pos())
		get_node("Question/Path2D1").set_global_pos(get_node("Question/Container/right").get_global_pos())
		get_node("Question/Path2D2").set_global_pos(get_node("Question/Container/bleft").get_global_pos())
		get_node("Question/Path2D3").set_global_pos(get_node("Question/Container/bright").get_global_pos())
	if curveno == 5:
		get_node("Question/Path2D0").set_global_pos(get_node("Question/Container/left").get_global_pos())
		
		get_node("Question/Path2D1").set_global_pos(get_node("Question/Container/right").get_global_pos())
		get_node("Question/Path2D2").set_global_pos(get_node("Question/Container/mid").get_global_pos())
		get_node("Question/Path2D3").set_global_pos(get_node("Question/Container/bleft").get_global_pos())
		get_node("Question/Path2D4").set_global_pos(get_node("Question/Container/bright").get_global_pos())
#		audio.get_node("SamplePlayer2D").play("spshield")
	for i in range(0,curveno):
		
		if curve != null:
			get_node("Question/Path2D"+str(i)).set_curve(curve)
		for j in range(0,no):
			print(j)
			
			var item =Ball.instance()
#			add_color_override("font_color", Color())
			get_node("Question/Path2D"+str(i)).add_child(item)
			item.get_child(0).set_texture(ball)
			item.get_child(1).add_color_override("font_color", Color(ringcolor[0],ringcolor[1],ringcolor[2],1))
			if schange > 0 and schange < 4:
				item.set_scale(Vector2(1.3,1.3))
			item.set_pos(get_node("Question/Path2D"+str(i)).get_curve().get_point_pos(j))
			if arr[i*no + j] == 0:
				item.get_child(1).add_color_override("font_color", Color(1,0,0,1))
				item.get_child(1).set_text("?")
			else:
				item.get_child(1).set_text(str(arr[i*no + j]))
#			item.get_child(2).play("New Anim")
			print(i*no + j)
			yield(utils.create_timer(waittime),"timeout")

func getanswer():
	utils.helppressed = false
	var a1 = int(rand_range(1,4))
	var a2 = int(rand_range(1,4))
	var a3 = int(rand_range(4,6))
	if a1 == 3:
		ansr[2] = answer - a3
	else:
		ansr[2] = answer + a3
	ansr[0] = answer + a1
	ansr[1] = answer - a2
	ansr[3] = answer
	for i in range(0,4):
		var k = (i+a1) % 4
		get_node("ansbox/q" + str(k+1)+ "/Label").set_text(tr(str(ansr[i])))
		if i == 3:
			answerbox = k+1
	pass

func _on_infotime_timeout():
	get_node("ui/CanvasLayer/levelinfo/AnimationPlayer").play("animout")
	yield(utils.create_timer(0.5),"timeout")
	utils.helppressed = false
	
	select_level1()
	
	pass # replace with function body

func answer():
		if utils.level == 3:
			ans = "The number at the centre of each triangle equals the sum of the lower two numbers minus the top number."
		if utils.level == 2:
			ans = "As you move diagonally down, numbers follow the sequence of Prime Numbers."
		if utils.level == 1:
			ans = "Starting bottom left and moving clockwise around the triangle, numbers follow the sequence of Square Numbers."
		if utils.level == 4:
			ans = "Working from top to bottom, double each number and subtract 1, then 2, then 3 etc."
		if utils.level == 5:
			ans = "Working in columns, the sum of the numbers in each column is always 14."
		if utils.level == 6:
			ans = "The numbers in each row and column add up to 15."
		if utils.level == 7:
			ans = "Moving from left to right, numbers increase by 2,3,4 and 5."
		if utils.level == 8:
			ans = "Moving clockwise, around alternate segments in the chain, one sequence decreases by 1, 2, 3 and 4 each time, while the other increases by 2, 3, 4 and 5."
		if utils.level == 9:
			ans = "Starting with the numbers in the top row, and following straight lines through the centre of the diagram, subtract the middle number from the top number to give the corresponding value on the bottom row."
		if utils.level == 10:
			ans = "In each circle, starting at the top left segment, numbers increase, as you move clockwise, by 2 for the upper left circle, 3 for the upper right, 4 for the lower right and 5 for the lower left."
		if utils.level == 11:
			ans = "In each group of 3 numbers, the lower number equals the average of the top two numbers."
		if utils.level == 12:
			ans = "Reading each row as a 3 digit number, the rows follow the sequence of square numbers, from 17 to 19."
		if utils.level == 13:
			ans = "Reading each pair of numbers as a 2 digit number, they follow the sequence of square numbers from 6 to 9."
		if utils.level == 14:
			ans = "In each row of the diagram, the sum of the left and right hand digits, minus the central digit is always 8."
		if utils.level == 15:
			ans = "Starting at the top left, and moving through the diagram in a Z shape, double each number and add 3 to give the next number along."
		if utils.level == 16:
			ans = "Moving to the right, double each number and subtract 3 to give the next number along."
		if utils.level == 17:
			ans = "Starting with the 10 at the top, one set of numbers increases by 3 each time, written in alternate boxes as you move down the diagram, and the other set of numbers decreases by 2, written in the boxes remaining"
		if utils.level == 18:
			ans = "On each row, add the values of the left hand and central boxes to give the value in the right hand box."
		if utils.level == 19:
			ans = "In each star diagram, the number in the centre equals the sum of the top three numbers, subtracting the sum of the bottom two numbers."
		if utils.level == 20:
			ans = "Starting top left, and moving down in columns from left to right, the numbers follow the sequence of Prime Numbers from 2 to 23."
		if utils.level == 21:
			ans = "Numbers in the segments of the left hand circle equal the difference between numbers in corresponding segments of the two right hand circles."
		if utils.level == 22:
			ans = "Starting with the top 3 digit number, the first digit increases by 2 as you descend, from 1 to 11. The middle digit decreases by 1 each time, and the right hand digit alternates between 5 and 3."
		if utils.level == 23:
			ans = "Numbers in the lower left circle equal the sum of the numbers in corresponding segments of the top two circles, and numbers in the lower right circle equal the difference of the numbers in corresponding segments of the top two circles."
		if utils.level == 24:
			ans = "In each triangle, the central number equals the sum of the three outer numbers divided by two."
		if utils.level == 25:
			ans = "In each star, the central number equals the difference between the sum of the even numbers and the sum of the odd numbers from the points of the star."
		if utils.level == 26:
			ans = "In each triangle, the number at the apex of the triangle equals the average of the two numbers at the bottom."
		if utils.level == 27:
			ans = "In each circle, the lower number equals the product of the top two numbers, subtracting 3 for the left hand circle, 4 for the middle, and 5 for the right hand circle."
		if utils.level == 28:
			ans = "In each diamond, add the left and right hand numbers together, and subtract this sum from the top number to give the value at the bottom."
		if utils.level == 29:
			ans = "In each H shape, the central number is equal to the difference between the sum of the 3 left hand numbers and the sum of the 3 right hand numbers."
		if utils.level == 30:
			ans = "Reading each row of the diagram as a series of 3 digit numbers, the centre 3 digit number equals the sum of the top 2 numbers, and the sum of the lower 2 numbers."
		if utils.level == 31:
			ans = "Add together values in corresponding positions of the top two crosses, and put the results in the lower left cross.Calculate the difference between values in corresponding positions of the top two crosses, and put the results in the lower right cross.Finally, add together the values in corresponding positions of the lower two crosses to give the values in the central cross."
		if utils.level == 32:
			ans = "Each number represents the numerical value of the vowels in the alphabet."
		if utils.level == 33:
			ans = "In each group of circles, the centre number equals the average of the four surrounding numbers."
		if utils.level == 34:
			ans = "In each diagram, the sum of the upper left and upper middle numbers is written in the centre box, and the sum of the upper right and upper middle numbers is written in the lower central box."
		if utils.level == 35:
			ans = "Moving from left to right, numbers follow the sequence of square numbers, from 6 to 10, subtracting 4 each time."
		if utils.level == 36:
			ans = "Reading each pair of numbers in a row as a 2 digit number, values increase by 6 each time."
		if utils.level == 37:
			ans = "Reading each column as a 3 digit number, moving from left to right, the columns follow the sequence of cube numbers of 5, 6 and 7."
		if utils.level == 38:
			ans = "In each star, the central value equals the sum of the upper and lower digits on each star, subtracting the sum of the left and right hand digits."
		if utils.level == 39:
			ans = "In each circle, double the numbers on the left hand side and put the result in the opposite segment on the right hand side."
		if utils.level == 40:
			ans = "In each circle, the number in the lower left segment equals the sum of the numbers in the top two segments, and the number in the lower right circle equals the difference between the numbers in the top two segments."
		if utils.level == 41:
			ans = "Working from left to right, the sum of the two smaller numbers on each triangle equals the third number."
		if utils.level == 42:
			ans = "Moving clockwise around the chain, numbers increase by 4, then 3, then 2, before repeating this pattern."
		if utils.level == 43:
			ans = "In each triangle, multiply the lower two numbers together and add the upper number to give the value at the centre."
		if utils.level == 44:
			ans = "Numbers in the segments of the lower left circle equal the sum of the numbers in the upper left and central circles. Numbers in the segments of the lower right circle equal the sum of the numbers in corresponding segments of the upper right and central circles."
		if utils.level == 45:
			ans = "The numbers on the points of the lower triangle equal the sum of the numbers on corresponding points of the upper two triangles."
		if utils.level == 46:
			ans = "As you move down, subtract 3 from the previous number, then 5, 7, 9 and 11."
		if utils.level == 47:
			ans = "Taking any side of the triangle, the sum of the two corner digits is written in one of the circles on that side, and the difference is written in the other circle."
		if utils.level == 48:
			ans = "Starting in the top left and moving in a Z shape around the diagram, each number equals the sum of the previous 2 numbers."
		if utils.level == 49:
			ans = "Working in rows, the number in the central oval equals the sum of the left and right hand numbers, divided by 3."
		if utils.level == 50:
			ans = "Starting with the bottom line of the triangle and moving up, the sum of the digits in each line decreases by 5 each time, from 20 to 5."
		if utils.level == 51:
			ans = "Numbers in the squares of the top middle figure equal the sum of the numbers in corresponding squares of the other 3 figures."
		if utils.level == 52:
			ans = "Starting at the top left and working down, then to the right and up, and finally to the right and down in a zig-zag shape, numbers follow the repeated sequence, subtracting 1 then adding 3 etc."
		if utils.level == 53:
			ans = "As you move down, the numbers represent multiples of 12, subtracting 1, for the first step, adding 2 for the second, subtracting 3 for the third, adding 4 for the next etc. etc."
		if utils.level == 54:
			ans = "In each row, the sum of the digits is 10."
		get_node("ui/CanvasLayer/answer/ScrollContainer/Label").set_text(ans)
		get_node("ui/CanvasLayer/answer/Label").set_text("Answer -: " + str(answer))
		utils.answerpressed = true
		utils.opanswer =0.7
		get_node("gamebtn/rateus").set_opacity(utils.opanswer)
		utils.lifeline -= 1
		get_node("ui/CanvasLayer/answer/AnimationPlayer").play("animin")
		utils.helppressed = true
		lifelinepressed = false
		pass

func _on_ansback_pressed():
	get_node("ui/CanvasLayer/answer/AnimationPlayer").play("animout")
	get_node("AnimationPlayer").play("New Anim")
	utils.answerpressed = false
	pass # replace with function body


func _on_check_pressed():
	right_answer()
	pass # replace with function body


func _on_guideback_pressed():
	guidepressed = false
	get_node("ui/CanvasLayer/btnguide/AnimationPlayer").play("animout")
	yield(utils.create_timer(0.2),"timeout")
	if guidemenu:
		guidemenu = false
		get_node("AnimationPlayer").play("New Anim")
	else:
		calllevelinfo()
	pass # replace with function body


func _on_guide_pressed():
	settingpressed = false
	guidepressed = true
	guidemenu = true
#	audio.get_node("SamplePlayer2D").play("hit")
#	get_node("soundbtn").set_scale(Vector2(0.55,0.55))
	get_node("ui/CanvasLayer/menuin/AnimationPlayer").play("animout")
	
	get_node("ui/CanvasLayer/btnguide/AnimationPlayer").play("animin")
	pass # replace with function body





func _on_share_pressed():
	settingpressed = false
	set_opacity(1)
	get_node("AnimationPlayer").play("New Anim")
	pass # replace with function body


func _on_rateus_pressed():
	if !utils.helppressed and !utils.answerpressed:
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("gamebtn/rateus").set_scale(btnbign)
		commonlifeline()
		lifelineno = 4
	pass # replace with function body


func _on_video_pressed():
#	utils.extralifegain = true
#	_on_Node2D_2_lifegain()
	if utils.network_error:
		get_node("ui/CanvasLayer/extralife/Label 2").show()
		yield(utils.create_timer(2),"timeout")
		get_node("ui/CanvasLayer/extralife/Label 2").hide()
	pass # replace with function body


func _on_extralifegain_timeout():
	get_node("upper/ProgressBar").set_value(get_node("upper/ProgressBar").get_value() + 90.0/20.0)
	pass # replace with function body
