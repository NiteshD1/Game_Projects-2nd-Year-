extends Node2D

var admob = null
var isReal = true
var isTop = false
var adBannerId = "ca-app-pub-4749905966048417/9766173339" # [Replace with your Ad Unit ID and delete this message.]
var adInterstitialId = "ca-app-pub-4749905966048417/8616743192" # [Replace with your Ad Unit ID and delete this message.]
var adRewardedId = "ca-app-pub-4749905966048417/7130726548" # [There is no testing option for rewarded videos, so you can use this id for testing]

func _ready():
	
	randomize()
	if(Engine.has_singleton("AdMob")):
		admob = Engine.get_singleton("AdMob")
		admob.init(isReal, get_instance_id())
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
	print("Network Error")

func _on_admob_ad_loaded():
	print("Ad loaded success")


func _on_interstitial_not_loaded():
	print("Error: Interstitial not loaded")

func _on_interstitial_loaded():
	print("Interstitial loaded")

func _on_interstitial_close():
	print("Interstitial closed")

func _on_rewarded_video_ad_loaded():
	print("Rewarded loaded success")

	
func _on_rewarded_video_ad_closed():
	print("Rewarded closed")
	loadRewardedVideo()
	
func _on_rewarded(currency, amount):
	print("Reward: " + currency + ", " + str(amount))

# Resize

func onResize():
	if admob != null:
		admob.resize()








func _on_backretry_pressed():



#func _on_TouchScreenButton_pressed():
#	if admob != null:
#			admob.showBanner()
#	pass # replace with function body

#
#func _on_back_pressed():
#	if admob != null:
#			admob.hideBanner()
#	pass # replace with function body
#
#
#func _on_retry_pressed():
#		if admob != null:
#			admob.hideBanner()
#
#
#func _on_backtoui_pressed():
#		if admob != null:
#			admob.hideBanner()
##			loadBanner()
	pass


func _on_Timer_timeout():
	print("ad")
	
	if admob != null:
			admob.hideBanner()
	pass # replace with function body
