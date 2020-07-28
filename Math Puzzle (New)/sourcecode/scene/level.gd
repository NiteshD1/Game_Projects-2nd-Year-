extends Node2D

var level= null
var fileobj= null
var fileobj1= null
var curfileobj= null
onready var main = load("res://scene/main.tscn")

func _ready():
	utils.connect("levelshow", self, "_on_levelshow")
	utils.connect("backlevel", self, "_on_backlevel") 
	utils.connect("loadlevel", self, "_on_loadlevel")   
	fileobj = utils.loadfile()
	level = int(get_node("Label").get_text())
	pass


func _on_Sprite_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	if !get_node("Sprite 2").is_visible():
		
		utils.first_time = false
		if utils.wordmode:
			utils.level = int(get_node("Label").get_text()) + (utils.wordstage-1)*100
			utils.learnmode = true
		else:
			utils.sentencelevel = int(get_node("Label").get_text()) + (utils.sentencestage-1)*100
			utils.learnmode = false
		utils.gamemode = false
		utils.indirect = true
		get_tree().change_scene_to(main)
	pass # replace with function body

func _on_levelshow():
	var temp= null
	if utils.wordmode:
		curfileobj = fileobj
		temp = (utils.wordstage -1)*100
	else:
		curfileobj = fileobj1
		temp = (utils.sentencestage -1)*100
	print("k")
	if level <= (curfileobj[0] - temp):
		get_node("Sprite 2").hide()
		if(curfileobj[level] == 1):
			get_node("Container/star1").show()
		if(curfileobj[level] == 2):
			get_node("Container/star1").show()
			get_node("Container/star2").show()
		if(curfileobj[level] == 3):
			get_node("Container/star1").show()
			get_node("Container/star2").show()
			get_node("Container/star3").show()

func _on_backlevel():
	yield(utils.create_timer(0.5),"timeout")
	get_node("Sprite 2").show()
	get_node("Container/star1").hide()
	get_node("Container/star2").hide()
	get_node("Container/star3").hide()
func _on_loadlevel():
	fileobj = utils.loadfile()
	fileobj1 = utils.loadfile1()
