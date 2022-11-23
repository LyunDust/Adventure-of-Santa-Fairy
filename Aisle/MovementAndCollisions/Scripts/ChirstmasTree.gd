extends Area2D

onready var deco = get_node("/root/Aisle/Player/UI_Text/PressKey_deco")


func _on_ChirstmasTree_body_entered(body):
	deco.visible = true


func _on_ChirstmasTree_body_exited(body):
	deco.visible = false
