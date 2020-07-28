extends Node2D

var fileobj

onready var main = preload("res://scene/main.tscn")

func _ready():
	fileobj = utils.loadfile()
	var level = int($Label.get_text())

	if level <= fileobj[0]:
		$Sprite2.hide()
		if(fileobj[level] == 1):
			$Container/star1.show()
		if(fileobj[level] == 2):
			$Container/star1.show()
			$Container/star2.show()
		if(fileobj[level] == 3):
			$Container/star1.show()
			$Container/star2.show()
			$Container/star3.show()
	pass


func _on_Sprite_pressed():
	audio.get_node("click").play()
	if !$Sprite2.is_visible_in_tree():
		utils.level = int($Label.get_text())
		get_tree().change_scene_to(main)
	pass # replace with function body
