extends Area2D

@onready var player = $"../Player"

var velocity = 350

var old_speed = Vector2.ZERO

var curve_soft = 0.05

func _ready() -> void:
	if old_speed == Vector2.ZERO:
		old_speed = player.position - position
		old_speed = old_speed.normalized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = player.position - position
	direction = direction.normalized()
	var direct_speed = direction 
	var speed = direct_speed * curve_soft + old_speed * (1 - curve_soft)
	position += speed * delta * velocity
	old_speed = speed
	
	$Sprite2D.rotation = speed.angle()



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		PlayerStats.lives -= 1
		queue_free()
	else:
		queue_free()
