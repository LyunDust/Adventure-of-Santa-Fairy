extends Area2D

onready var hide = get_node("/root/Aisle/Player/UI_Text/PressKey_hide")

var boxXPos

func _ready():
	boxXPos = rand_range(80, 3700)	
	self.set_position(Vector2(boxXPos, 517))


func _on_Box_body_entered(body):
	if body is AislePlayer:
		hide.visible = true


func _on_Box_body_exited(body):
	if body is AislePlayer:
		hide.visible = false
