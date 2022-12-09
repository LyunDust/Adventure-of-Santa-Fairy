#Owner: ParkSinYoung
extends Control

#Adjust the volume of the background sound used on each screen

onready var mainSlider = $ColorRect/MainSlider
#Slider to adjust the music volume on the start screen
onready var storySlider = $ColorRect/StorySlider
#Slider to adjust the music volume on the story screen
onready var level1Slider = $ColorRect/Level1Slider
#Slider to adjust the music volume on the level1 game screen
onready var level2Slider = $ColorRect/Level2Slider
#Slider to adjust the music volume on the level2 game screen
var mainVolume #music volume on the start screen
var storyVolume #music volume on the story screen
var level2Volume #music volume on the level2 game screen
var bgm_bus = AudioServer.get_bus_index("BGM") #level1 Bus corresponding to music

func _ready():
	#Gets the preset music volume and sets it to the value of the slider
	#By default, the Options screen plays music from the Start screen
	mainVolume = BackGroundMusic.get_startScreenmusicVol()
	mainSlider.value = mainVolume
	storyVolume = BackGroundMusic.get_storyScreenmusicVol()
	storySlider.value = storyVolume
	level1Slider.value = BackGroundMusic.get_level1MusicVol()
	level2Volume = BackGroundMusic.get_level2SceneMusicVol()
	level2Slider.value = level2Volume
	

func _on_Button_button_up():
	##Press the Quit button to return to the start screen
	get_tree().change_scene("res://scenes/StartScreen.tscn")


func _on_MainSlider_value_changed(value):
	#If the value of the slider changes, set the volume to that value
	#Set the value of the slider to the value of the volume as well
	BackGroundMusic.set_startScreenmusicVol(value)
	mainSlider.value = value


func _on_StorySlider_value_changed(value):
	#If the value of the slider changes, set the volume to that value
	#Set the value of the slider to the value of the volume as well
	BackGroundMusic.set_storyScreenmusicVol(value)
	storySlider.value = value

#When adjusting the volume of music on a screen other than the start screen,
#stop the music on the start screen and play the music on that screen 
#to see the volume change directly

func _on_StorySlider_drag_started():
	BackGroundMusic.pause_startScreenmusic()
	BackGroundMusic.play_storySceneMusic()


func _on_StorySlider_drag_ended(value_changed):
	BackGroundMusic.play_startScreenmusic()
	BackGroundMusic.pause_storySceneMusic()


func _on_Level1Slider_value_changed(value):
	#If the value of the slider changes, set the volume to that value
	#Set the value of the slider to the value of the volume as well
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


func _on_Level2Slider_value_changed(value):
	#If the value of the slider changes, set the volume to that value
	#Set the value of the slider to the value of the volume as well
	BackGroundMusic.set_level2SceneMusicVol(value)
	level2Slider.value = value


func _on_Level2Slider_drag_started():
	BackGroundMusic.pause_startScreenmusic()
	BackGroundMusic.play_level2SceneMusic()


func _on_Level2Slider_drag_ended(value_changed):
	BackGroundMusic.play_startScreenmusic()
	BackGroundMusic.pause_level2SceneMusic()
