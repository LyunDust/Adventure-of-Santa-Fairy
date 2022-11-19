extends Sprite


var life = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_playerDamage():
	if life == 3:
		$life3.set_modulate(Color(0.3, 0.3, 0.3))
	elif life == 2:
		$life2.set_modulate(Color(0.3, 0.3, 0.3))
	elif life == 1:
		$life1.set_modulate(Color(0.3, 0.3, 0.3))
	life -= 1
