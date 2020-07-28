extends Node
var volume
signal changevolume
func _ready():
	
	connect("changevolume",self,"onvolumechange")
	pass
func onvolumechange():
	$Bg.volume_db = volume -14
	$Start.volume_db = volume
	$Button.volume_db = volume
	$Coin.volume_db = volume
	$Life.volume_db = volume
	$Lifeshow.volume_db = volume
	$Shield.volume_db = volume
	$Powers.volume_db = volume
	$Move.volume_db = volume
	$Gameover.volume_db = volume
	$Gameover2.volume_db = volume
	$Arrow.volume_db = volume
