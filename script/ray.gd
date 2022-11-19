extends Area2D

var num
var isSeeing = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$textBalloon.visible = false
	randomize()
	$raySprite.visible = false
	$textBalloonTimer.start()
	$sensor.position.x = $CollisionShape2D.shape.get_extents().x-12
	$sensor2.position.x = $CollisionShape2D.shape.get_extents().x-3

func _physics_process(delta):
	if isSeeing == true:
		if $sensor.is_colliding() or $sensor2.is_colliding():
			get_tree().paused = true


func _on_Timer_timeout():
	$raySprite.visible = false
	isSeeing = false


func _on_textBalloonTimer_timeout():
	num = rand_range(0, 10)
	if num > 2:
		$textBalloon.visible = true
		$textBalloonTimer/smallTimer.start()


func _on_smallTimer_timeout():
	$textBalloon.visible = false
	isSeeing = true
	$raySprite.visible = true
	$Timer.start()
