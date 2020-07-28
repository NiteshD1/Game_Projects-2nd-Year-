 extends Control

signal animout
signal qshow
signal qhide
#export(PackedScene) var ui

onready var play = preload("res://image/play.png")
onready var pause = preload("res://image/pause.png")
onready var ui = preload("res://scene/ui.tscn")


func _ready():
	print(utils.qtime)
	utils.connect("gemscore",self,"score_changed")

	pass


func _on_TouchScreenButton_pressed():
		audio.get_node("SamplePlayer2D").play("hit")
		if get_node("CanvasLayer/TouchScreenButton").normal == play:
			get_node("CanvasLayer/Popup/AnimationPlayer").play_backwards("animin")
#			audio.get_node("bg").play()
			get_tree().set_pause(false)
			emit_signal("qshow")
			get_node("CanvasLayer/TouchScreenButton").normal = pause
		else:
			get_node("CanvasLayer/TouchScreenButton").normal = play
			get_node("CanvasLayer/Popup/AnimationPlayer").play("animin")
			emit_signal("qhide")
			yield(utils.create_timer(0.5),"timeout")
#			audio.get_node("bg").stop()
			get_tree().set_pause(true)
			get_node("CanvasLayer/TouchScreenButton").set_pause_mode(Node.PAUSE_MODE_PROCESS)
			get_node("CanvasLayer/Popup").set_pause_mode(Node.PAUSE_MODE_PROCESS)




#func _on_Popup_popup_hide():
#	get_tree().paused = false
#	$CanvasLayer/TouchScreenButton.normal = pause
#	pass # replace with function body


func _on_main_playerout():
	audio.get_node("SamplePlayer2D").play("player died")
	get_node("CanvasLayer/Popupdied/AnimationPlayer1").play("animin")
	emit_signal("animout")
	get_node("CanvasLayer/Popupdied/AnimationPlayer").play("New Anim")
	pass # replace with function body
	

	


func _on_retry_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	
	get_node("CanvasLayer/Popuprestart/AnimationPlayer").play_backwards("animin")
	yield(utils.create_timer(0.5),"timeout")
	get_tree().reload_current_scene()
	
	pass # replace with function body


func _on_backtoui_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("CanvasLayer/Popuprestart/AnimationPlayer").play_backwards("animin")
	
	yield(utils.create_timer(0.5),"timeout")
	get_tree().change_scene_to(ui)
	pass # replace with function body


func _on_back_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
#	get_node("CanvasLayer/TouchScreenButton").normal = pause
	emit_signal("animout")
	get_node("CanvasLayer/TouchScreenButton").normal = pause
	get_node("CanvasLayer/Popup/AnimationPlayer").play("animout")
	get_tree().set_pause(false)
	get_node("CanvasLayer/Popuprestart/AnimationPlayer").play("animin")
	pass # replace with function body





#func _on_backretry_pressed():
#	$CanvasLayer/Popuprestart.show()
#	$CanvasLayer/Popupdied.hide()
#	pass # replace with function body


func _on_cross_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
#	get_node("CanvasLayer/").normal = pause
	get_node("CanvasLayer/Popup").hide()
	pass # replace with function body





func _on_btn1_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	var btn = get_node("CanvasLayer/Keyboard/HBoxContainer/btn1/Label").get_text()
	set_label(btn)
	
	pass # replace with function body
	
func set_label(var btn):
	if btn == "?":
		get_node("CanvasLayer/Label").set_text(btn)
	else:
		var previous = int(get_node("CanvasLayer/Label").get_text())*10
		get_node("CanvasLayer/Label").set_text(str(previous + int(btn)))




func _on_btn2_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	var btn = get_node("CanvasLayer/Keyboard/HBoxContainer/btn2/Label").get_text()
	set_label(btn)
	pass # replace with function body


func _on_btn3_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	var btn = get_node("CanvasLayer/Keyboard/HBoxContainer/btn3/Label").get_text()
	set_label(btn)
	pass # replace with function body


func _on_btn4_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	var btn = get_node("CanvasLayer/Keyboard/HBoxContainer/btn4/Label").get_text()
	set_label(btn)
	pass # replace with function body


func _on_btn5_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	var btn = get_node("CanvasLayer/Keyboard/HBoxContainer/btn5/Label").get_text()
	set_label(btn)
	pass # replace with function body


func _on_btn6_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	var btn = get_node("CanvasLayer/Keyboard/HBoxContainer/btn6/Label").get_text()
	set_label(btn)
	pass # replace with function body


func _on_btn7_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	var btn = get_node("CanvasLayer/Keyboard/HBoxContainer/btn7/Label").get_text()
	set_label(btn)
	pass # replace with function body


func _on_btn8_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	var btn = get_node("CanvasLayer/Keyboard/HBoxContainer/btn8/Label").get_text()
	set_label(btn)
	pass # replace with function body


func _on_btn9_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	var btn = get_node("CanvasLayer/Keyboard/HBoxContainer/btn9/Label").get_text()
	set_label(btn)
	pass # replace with function body


func _on_btn10_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	var btn = get_node("CanvasLayer/Keyboard/HBoxContainer/btn10/Label").get_text()
	set_label(btn)
	pass # replace with function body


func _on_btncross_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	var previous = int(get_node("CanvasLayer/Label").get_text())/10
	get_node("CanvasLayer/Label").set_text(str(previous))
	pass # replace with function body







#func _on_Answerbtn_pressed():
#	get_node("CanvasLayer/Popup/AnimationPlayer").play("animin")
#	if utils.level == 1:
#		get_node("CanvasLayer/Popup/ScrollContainer/Label").set_text("The number at the centre of each triangle equals the sum of the lower two numbers minus the top number.")
#	pass # replace with function body


func _on_Button_pressed():
	if not utils.menupressed:
		utils.menupressed = true
		audio.get_node("SamplePlayer2D").play("hit",1)
		get_node("menuin/AnimationPlayer").play("animin")
	pass # replace with function body


func _on_Label2_pressed():
	utils.menupressed = false
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("menuin/AnimationPlayer").play("animout")
	yield(utils.create_timer(0.02),"timeout")
	get_node("controlinfo/AnimationPlayer").play("animin")
	pass # replace with function body


func _on_Label_pressed():
	utils.menupressed = false
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Popup2/AnimationPlayer").play("animin")
	yield(utils.create_timer(0.15),"timeout")
	get_node("menuin/AnimationPlayer").play("animout")
	pass # replace with function body


func _on_backmain_pressed():
	utils.menupressed = false
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("menuin/AnimationPlayer").play("animout")
	pass # replace with function body


func _on_LinkButton_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	OS.shell_open("https://bouncingbox2.blogspot.com/p/bouncing-box-privacy-policy.html")
	pass # replace with function body


func _on_back__pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("controlinfo/AnimationPlayer").play("animout")
	yield(utils.create_timer(0.15),"timeout")
	get_node("menuin/AnimationPlayer").play("animin")
	pass # replace with function body


func _on_backmenu_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Popup2/AnimationPlayer").play("animout")
	get_node("menuin/AnimationPlayer").play("animin")
	pass # replace with function body


func _on_next_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Popup2/ScrollContainer").set_h_scroll(get_node("Popup2/ScrollContainer").get_h_scroll() + 130)
	pass # replace with function body


func _on_previous_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Popup2/ScrollContainer").set_h_scroll(get_node("Popup2/ScrollContainer").get_h_scroll() - 130)
	pass # replace with function body

func demo():
	if utils.level == 55:
			ans = "In each diagram multiply top two values and add their sum to give the bottom value."
	if utils.level == 56:
			ans = "Find the difference of first two numbers in each row and double it to get third number in that row."
	if utils.level == 57:
			ans = "Sum of numbers on each line is 15."
	if utils.level == 58:
			ans = "9/3 = 3;6/2 = 3;8/4 = 2;"
	if utils.level == 59:
			ans = "Multiply two numbers in first row in each rectangle and put that whole number in next row."
	if utils.level == 60:
			ans = "Add numbers in each row and result is same as left number in next row."
	if utils.level == 61:
			ans = "See numbers column wise.7-5+4 = 6;6-4+7 = 9;5-1+3 = 7;4-2+8 = 10"
	if utils.level == 62:
			ans = "In first 7*8 = 56;In second circle,4*7 = 28;So, based on above rule, in third circle,9*3 = 27;So, missing number in third circle is 3."
	if utils.level == 63:
			ans = "In the above puzzle, sum of corner numbers and sum of middle numbers is equal to 34."
	if utils.level == 64:
			ans = "In the above puzzle, in each row, subtract the second number from first number to get the third number and add the first two numbers to get the fourth number."
	if utils.level == 65:
			ans = "In the above puzzle, the sum of numbers at respective positions in each triangle is equal to 100."
	if utils.level == 66:
			ans = "In each box, take average of first and last number in each row and multiply the average with 3 to get middle number.(7+11)  /    2  =  9 * 3  =  27  ;"
	if utils.level == 67:
			ans = "In the figure shown above, sum of numbers in each rectangular box is equal to 31."
	if utils.level == 68:
			ans = "In the above math puzzle, in each circle sum of even numbers is equal to sum of odd numbers."
	if utils.level == 69:
			ans = "In the above puzzle, in each square subtract the sum of the bottom row numbers from sum of the top row numbers to get the middle number."
	if utils.level == 70:
			ans = "Working in rows, invert the digits in the left and right hand numbers and add them together to give the central figure."
	if utils.level == 71:
			ans = "To get the solution, add half of the first number and double of the second number to get third number in each row."
	if utils.level == 72:
			ans = "The center figure is the product of left and right numbers minus 1."
	if utils.level == 73:
			ans = "In each column, the sum of the three smaller figures equals the larger figure."
	if utils.level == 74:
			ans = "Add the top 2 digits in each group and multiply the center and result is written in the bottom circles."
	if utils.level == 75:
			ans = "working in columns from top to bottom, on the left, multiply each value by 2 then subtract 2 to give the next number. In the center column by 3 and the right hand column by 4."
	if utils.level == 76:
			ans = "working on rows, the central number is equal to the difference in the squares of the left and right hand numbers."
	if utils.level == 77:
			ans = "The number in the center of each triangle equals the product of bottom two digits plus the top digit"
	if utils.level == 78:
			ans = "working in rows, the central value equals the sum of squares of the left and right hand numbers."
	if utils.level == 79:
			ans = "In rows the right hand number equals the difference between left and center number."
	if utils.level == 80:
			ans = "In each triangle the center number equals the sum of the two lower number minus the top number."
	if utils.level == 81:
			ans = "Numbers are following the below order. Add 6 and then 7 to the top numbers. Similarly add 5 and 6 for bottom left and 7,8 for the bottom right numbers."
	if utils.level == 82:
			ans = "Starting at top left and working down and bottom right and working up add the left hand number to the right hand number and put this answer in center column reading downwards."
	if utils.level == 83:
			ans = "In each circle multiply upper left number by 2 and subtract 1 to give upper right number. Similarly multiply upper left number with 3 and subtract 1 from it to get lower number."
	if utils.level == 84:
			ans = "In the above math puzzle, from top left corner numbers are following prime number sequence along each row.2, 3, 5, 7, 11, 13, 17, 19, 23."
	if utils.level == 85:
			ans = ""
	if utils.level == 86:
			ans = ""
	if utils.level == 87:
			ans = ""
	if utils.level == 88:
			ans = ""
	if utils.level == 89:
			ans = ""
	if utils.level == 90:
			ans = ""
	if utils.level == 91:
			ans = ""
	if utils.level == 92:
			ans = ""
	if utils.level == 93:
			ans = ""
	if utils.level == 94:
			ans = ""
	if utils.level == 95:
			ans = ""
	if utils.level == 96:
			ans = ""
	if utils.level == 97:
			ans = ""
	if utils.level == 98:
			ans = ""
	if utils.level == 99:
			ans = ""
	if utils.level == 100:
			ans = ""
	if utils.level == 101:
			ans = ""
	if utils.level == 102:
			ans = ""
	if utils.level == 103:
			ans = ""
	if utils.level == 104:
			ans = ""
	if utils.level == 105:
			ans = ""
	if utils.level == 106:
			ans = ""
	if utils.level == 107:
			ans = ""
	if utils.level == 108:
			ans = ""
	if utils.level == 109:
			ans = ""
	if utils.level == 110:
			ans = ""
	