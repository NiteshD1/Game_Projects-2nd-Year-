extends Node2D

var fileobj

onready var main = load("res://scene/main.tscn")

func _ready():
	fileobj = utils.loadfile()
	var level = int(get_node("Label").get_text())

	if level <= fileobj[0]:
		get_node("Sprite 2").hide()
		if(fileobj[level] == 1):
			get_node("Container/star1").show()
		if(fileobj[level] == 2):
			get_node("Container/star1").show()
			get_node("Container/star2").show()
		if(fileobj[level] == 3):
			get_node("Container/star1").show()
			get_node("Container/star2").show()
			get_node("Container/star3").show()
	pass


func _on_Sprite_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	if !get_node("Sprite 2").is_visible():
		utils.level = int(get_node("Label").get_text())
		get_tree().change_scene_to(main)
	pass # replace with function body



