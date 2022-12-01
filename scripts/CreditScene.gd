extends Control

var bgm_bus = AudioServer.get_bus_index("BGM")

func _on_Button_button_up():
	get_tree().change_scene("res://scenes/StartScreen.tscn")


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(bgm_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(bgm_bus, true)
	else:
		AudioServer.set_bus_mute(bgm_bus, false)
