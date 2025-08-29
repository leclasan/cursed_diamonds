extends Area2D

var grounded = false

var damage = 50

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not grounded:
		position.y += 200 * delta

func _on_body_entered(body: Node2D) -> void:
	if body is tilemap:
		grounded = true


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		queue_free()
