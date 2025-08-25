extends Area2D

var speed = 500
var direction

var damage = 50

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.x += speed * delta * direction


func _on_area_entered(area: Area2D) -> void:
	if not area.is_in_group("Weapons"):
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Players"):
		queue_free()
