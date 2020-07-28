extends Node2D
var sbanner = true
var admob = null
var isReal = true
var isTop = false
var i = 0
signal coinupdate
signal refresh

var adBannerId = "ca-app-pub-4749905966048417/8751402387" # [Replace with your Ad Unit ID and delete this message.]
var adInterstitialId = "ca-app-pub-4749905966048417/8200861755" # [Replace with your Ad Unit ID and delete this message.]
var adRewardedId = "ca-app-pub-4749905966048417/6768947310" # [There is no testing option for rewarded videos, so you can use this id for testing]

func _ready():
	if(Globals.has_singleton("AdMob")):
		admob = Globals.get_singleton("AdMob")
		admob.init(isReal, get_instance_ID())
		loadBanner()
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
	utils.network_error = true
	print("Network Error")

func _on_admob_ad_loaded():
	utils.network_error = false
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
	utils.coin += 50
	emit_signal("coinupdate")
	emit_signal("refresh")
	print("Reward: " + currency + ", " + str(amount))
	#get_node("CanvasLayer/LblRewarded").set_text("Reward: " + currency + ", " + str(amount))

# Resize

func onResize():
	if admob != null:
		admob.resize()
















func _on_coinadd_pressed():
	if admob != null:
		admob.showRewardedVideo()
	pass # replace with function body




func _on_home_pressed():
	if admob != null:
		admob.showInterstitial()
	pass # replace with function body


func _on_main_addinter():
	if admob != null:
		admob.showInterstitial()
	pass # replace with function body


func _on_Timer_timeout():
	if admob != null:
		if i % 2 == 0: admob.showBanner()
		else: admob.hideBanner()
		i += 1

		
	pass # replace with function body
