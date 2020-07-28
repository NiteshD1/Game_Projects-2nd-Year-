extends Node2D
var sbanner = true
var admob = null
var isReal = true
var isTop = false
signal answer
var adBannerId = "ca-app-pub-4749905966048417/8855475679" # [Replace with your Ad Unit ID and delete this message.]
var adInterstitialId = "ca-app-pub-4749905966048417/4727215328" # [Replace with your Ad Unit ID and delete this message.]
var adRewardedId = "ca-app-pub-4749905966048417/8444412135" # [There is no testing option for rewarded videos, so you can use this id for testing]

func _ready():
	if(Globals.has_singleton("AdMob")):
		admob = Globals.get_singleton("AdMob")
		admob.init(isReal, get_instance_ID())
#		loadBanner()
		loadInterstitial()
		loadRewardedVideo()
	
	get_tree().connect("screen_resized", self, "onResize")

# Loaders

func loadBanner():
	if admob != null:
		admob.loadBanner(adBannerId, isTop)

func loadInterstitial():
	if admob != null:
		admob.loadInterstitial(adInterstitialId)
		
func loadRewardedVideo():
	if admob != null:
		admob.loadRewardedVideo(adRewardedId)

# Events

#func _on_BtnBanner_toggled(pressed):
#	if admob != null:
#		if pressed: admob.showBanner()
#		else: admob.hideBanner()
#
#func _on_BtnInterstitial_pressed():
#	if admob != null:
#		admob.showInterstitial()
#		
#func _on_BtnRewardedVideo_pressed():
#	if admob != null:
#		admob.showRewardedVideo()

func _on_admob_network_error():
	print("Network Error")

func _on_admob_ad_loaded():
	print("Ad loaded success")
	#get_node("CanvasLayer/BtnBanner").set_disabled(false)

func _on_interstitial_not_loaded():
	print("Error: Interstitial not loaded")

func _on_interstitial_loaded():
	print("Interstitial loaded")
	#get_node("CanvasLayer/BtnInterstitial").set_disabled(false)

func _on_interstitial_close():
	print("Interstitial closed")
	#get_node("CanvasLayer/BtnInterstitial").set_disabled(true)

func _on_rewarded_video_ad_loaded():
	print("Rewarded loaded success")
	#get_node("CanvasLayer/BtnRewardedVideo").set_disabled(false)
	
func _on_rewarded_video_ad_closed():
	
	print("Rewarded closed")
	#get_node("CanvasLayer/BtnRewardedVideo").set_disabled(true)
	loadRewardedVideo()
	
func _on_rewarded(currency, amount):
	emit_signal("answer")
	print("Reward: " + currency + ", " + str(amount))
	#get_node("CanvasLayer/LblRewarded").set_text("Reward: " + currency + ", " + str(amount))

# Resize

func onResize():
	if admob != null:
		admob.resize()



func _on_TouchScreenButton_pressed():
	if sbanner:
		print("addd")
		if admob != null:
			admob.showBanner()
		sbanner = false
	else:
		if admob != null:
			admob.hideBanner()
		sbanner = true
		
	pass # replace with function body


func _on_TouchScreenButton_released():
	if admob != null:
		admob.hideBanner()
	pass # replace with function body


func _on_Answerbtn_pressed():
	if admob != null:
		admob.showRewardedVideo()
	pass # replace with function body


func _on_backtoui_pressed():
	print("addd")
	if admob != null:
		admob.showInterstitial()
	pass # replace with function body


func _on_changelevel_pressed():
	print("addd")
	if admob != null:
		admob.showInterstitial()
	pass # replace with function body


func _on_backretry_pressed():
	print("addd")
	if admob != null:
		admob.showInterstitial()
	pass # replace with function body
