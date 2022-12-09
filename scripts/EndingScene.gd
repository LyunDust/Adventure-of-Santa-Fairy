#Owner: ParkSinYoung
extends Control

func _ready():
	#Playing music on the ending screen
	BackGroundMusic.pause_storySceneMusic()
	BackGroundMusic.play_endingScreenmusic()

func _on_TextureButton_pressed():
	#Press Home Button to return to the Start screen
	BackGroundMusic.pause_endingScreenmusic()
	get_tree().change_scene("res://scenes/StartScreen.tscn")
