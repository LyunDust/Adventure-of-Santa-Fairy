extends Control

onready var mainSlider = $ColorRect/MainSlider
onready var storySlider = $ColorRect/StorySlider
onready var level1Slider = $ColorRect/Level1Slider
var mainVolume 
var storyVolume
var bgm_bus = AudioServer.get_bus_index("BGM")

func _ready():
	mainVolume = BackGroundMusic.get_startScreenmusicVol()
	mainSlider.value = mainVolume
	storyVolume = BackGroundMusic.get_storyScreenmusicVol()
	storySlider.value = storyVolume
	level1Slider.value = BackGroundMusic.get_level1MusicVol()

func _on_Button_button_up():
	#BackGroundMusic.play_startScreenmusic()
	get_tree().change_scene("res://scenes/StartScreen.tscn")


func _on_MainSlider_value_changed(value):
	BackGroundMusic.set_startScreenmusicVol(value)
	mainSlider.value = value


func _on_MainSlider_drag_started():
	BackGroundMusic.play_startScreenmusic()


func _on_MainSlider_drag_ended(value_changed):
	#BackGroundMusic.pause_startScreenmusic()
	pass


func _on_StorySlider_value_changed(value):
	BackGroundMusic.set_storyScreenmusicVol(value)
	storySlider.value = value


func _on_StorySlider_drag_started():
	BackGroundMusic.pause_startScreenmusic()
	BackGroundMusic.play_storySceneMusic()


func _on_StorySlider_drag_ended(value_changed):
	BackGroundMusic.play_startScreenmusic()
	BackGroundMusic.pause_storySceneMusic()


func _on_Level1Slider_value_changed(value):
	AudioServer.set_bus_volume_db(bgm_bus, value)
	level1Slider.value = value
	BackGroundMusic.set_level1MusicVol(value)


func _on_Level1Slider_drag_started():
	BackGroundMusic.pause_startScreenmusic()
	if !$ColorRect/Level1Slider/Level1Player.is_playing():
		$ColorRect/Level1Slider/Level1Player.play()


func _on_Level1Slider_drag_ended(value_changed):
	BackGroundMusic.play_startScreenmusic()
	if $ColorRect/Level1Slider/Level1Player.is_playing():
		$ColorRect/Level1Slider/Level1Player.stop()
