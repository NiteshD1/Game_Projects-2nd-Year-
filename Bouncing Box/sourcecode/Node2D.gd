extends Node2D

onready var c = preload("res://scene/rec.tres")

func _ready():
	$main/rectanglep.set_curve(c)
	pass
