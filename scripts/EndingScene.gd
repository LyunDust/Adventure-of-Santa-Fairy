extends Control

func _ready():
	BackGroundMusic.pause_storySceneMusic()
	BackGroundMusic.play_endingScreenmusic()

func _on_TextureButton_pressed():
	BackGroundMusic.pause_endingScreenmusic()
	get_tree().change_scene("res://scenes/StartScreen.tscn")
