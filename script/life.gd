extends Sprite


var life = 3


func _ready():
	pass # Replace with function body.

func _on_Player_playerDamage():
	if life == 3:
		$life3.set_modulate(Color(0.3, 0.3, 0.3))
	elif life == 2:
		$life2.set_modulate(Color(0.3, 0.3, 0.3))
	elif life == 1:
		$life1.set_modulate(Color(0.3, 0.3, 0.3))
	life -= 1
