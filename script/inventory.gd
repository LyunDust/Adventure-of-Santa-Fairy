#Owner: LeeSoyoung
extends Area2D

func _ready(): #initial item sprite setting: item1
	$item1.visible = true
	$item2.visible = false

func _on_Level_2_changeItem(): #change item sprite
	$item1.visible = !$item1.visible
	$item2.visible = !$item2.visible
