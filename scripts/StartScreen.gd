extends Node2D


func _on_StartButton_button_up():
	get_tree().change_scene("res://scenes/AisleStoryScene.tscn")


func _on_CreditButton_button_up():
	get_tree().change_scene("res://scenes/CreditScene.tscn")


func _on_OptionButton_button_up():
	get_tree().change_scene("res://scenes/OptionScene.tscn")
