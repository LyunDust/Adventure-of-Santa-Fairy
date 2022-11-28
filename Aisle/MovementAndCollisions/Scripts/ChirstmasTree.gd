# Owner: Kim Hyeri

extends Area2D

class_name ChirstmasTree

var treeXPos
var treeYPos

onready var deco = get_node("/root/Aisle/Player/UI_Text/PressKey_deco")

func _init():
	treeXPos = 1935
	treeYPos = 122
	self.set_position(Vector2(treeXPos, treeYPos))


func _on_ChirstmasTree_body_entered(body):
	if body is AislePlayer:
		deco.visible = true


func _on_ChirstmasTree_body_exited(body):
	if body is AislePlayer:
		deco.visible = false
