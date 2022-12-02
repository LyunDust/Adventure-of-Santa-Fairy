# Owner: Kim Hyeri
# This script is attached to ChirstmasTree.tscn

extends Area2D

class_name ChirstmasTree

# variables for christmas tree's position
var treeXPos
var treeYPos

# UI text
onready var text_pressKeyDeco = get_node("/root/Aisle/Player/UI_Text/PressKey_deco")


# set the tree's position
func _init():
	treeXPos = 1935
	treeYPos = 122
	self.set_position(Vector2(treeXPos, treeYPos))


# if the player collide with tree, the UI text is visible
func _on_ChirstmasTree_body_entered(body):
	if body is AislePlayer:
		text_pressKeyDeco.visible = true


# if the player doesn't collide with tree, the UI text isn't visible
func _on_ChirstmasTree_body_exited(body):
	if body is AislePlayer:
		text_pressKeyDeco.visible = false
