extends Area2D

var speed = 500
var direction

var damage = 50

var returning = false 

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if returning:
		position.x += speed * delta * direction * -1
	else:
		position.x += speed * delta * direction
	rotate(1)


func _on_body_entered(body) -> void:
	if body is tilemap:
		if returning:
			queue_free()
		else:
			returning = true


func _on_timer_timeout() -> void:
	returning = true
