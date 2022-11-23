extends Area2D


onready var hide = get_node("/root/Aisle/Player/UI_Text/PressKey_hide")


func _on_Box_body_entered(body):
	hide.visible = true


func _on_Box_body_exited(body):
	hide.visible = false
