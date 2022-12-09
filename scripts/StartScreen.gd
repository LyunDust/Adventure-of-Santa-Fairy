#Owner: ParkSinYoung

extends Node2D

#It is main screen

func _ready(): #Play the music on the main screen.
	BackGroundMusic.play_startScreenmusic()
	
func _on_StartButton_button_up():
	#Pressing the start button stops the music on the main screen 
	#and switches to the story screen.
	BackGroundMusic.pause_startScreenmusic()
	get_tree().change_scene("res://scenes/AisleStoryScene.tscn")


func _on_CreditButton_button_up():
	#Press this button to switch to the credit screen.
	get_tree().change_scene("res://scenes/CreditScene.tscn")


func _on_OptionButton_button_up():
	#Press this button to change to an option screen 
	#that allows you to adjust the sound.
	get_tree().change_scene("res://scenes/OptionScene.tscn")


