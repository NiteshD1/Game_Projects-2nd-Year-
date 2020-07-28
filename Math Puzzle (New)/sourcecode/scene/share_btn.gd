extends TouchScreenButton
signal coin_update
signal refresh
var share = null # our share singleton instance
var btnbig = Vector2(0.43,0.43)
var btnsmall = Vector2(0.4,0.4)
func _ready():
	# initialize the share singleton if it exists
	if Globals.has_singleton("GodotShare"):
		share = Globals.get_singleton("GodotShare")


func _on_share_pressed():
# get the current viewport and schedule a capture
	var view_port = get_viewport()
	view_port.queue_screen_capture()
	
	# wait two frames for the capture be ready
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	
	# The file must be saved at user:// root
	var image_save_path = OS.get_data_dir() + "/tmp.png"
	
	# actually takes the caputure
	var capture = view_port.get_screen_capture()
	# saves the capture as user://tmp.png
	capture.save_png(image_save_path)
	
	# if share was found, use it
	if share != null:
		share.sharePic(image_save_path, "Image Sharing", "Maths Puzzle","Use your mind and solve unlimited maths puzzles in very intersting way and earn coin.Now Its time to play very creative mind exercise game.It's totally free ,********Get the full free app now- https://play.google.com/store/apps/details?id=org.studyquiz.mathpuzzle")
		if !utils.sharepressed:
			utils.sharepressed = true
			yield(utils.create_timer(12),"timeout")
			utils.coin += 200
			emit_signal("coin_update")
			emit_signal("refresh")
			
	




func _on_blank_pressed():
	
	pass # replace with function body
