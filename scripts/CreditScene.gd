#Owner: ParkSinYoung
extends Control

#Press the Quit button to return to the start screen
func _on_Button_button_up():
	get_tree().change_scene("res://scenes/StartScreen.tscn")
