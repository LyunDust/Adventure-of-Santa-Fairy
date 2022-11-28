# Owner: Kim Hyeri

extends Area2D

onready var deco = get_node("/root/Aisle/Player/UI_Text/PressKey_deco")


func _on_ChirstmasTree_body_entered(body):
	if body is AislePlayer:
		deco.visible = true


func _on_ChirstmasTree_body_exited(body):
	if body is AislePlayer:
		deco.visible = false
