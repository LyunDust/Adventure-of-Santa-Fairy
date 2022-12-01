#Owner: LeeSoyoung
extends Sprite

var life = 3

#When it receives a signal, it changes the color of the sprite according to the number of life
#and reduces the life
func _on_Player_playerDamage():
	if life == 3:
		$life3.set_modulate(Color(0.3, 0.3, 0.3))
	elif life == 2:
		$life2.set_modulate(Color(0.3, 0.3, 0.3))
	elif life == 1:
		$life1.set_modulate(Color(0.3, 0.3, 0.3))
	life -= 1
