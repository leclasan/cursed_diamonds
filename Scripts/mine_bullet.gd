extends Area2D

var grounded = false

var damage = 0

var explosion_scene = preload("res://Scenes/explosion.tscn")

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
		var explosion = explosion_scene.instantiate()
		explosion.position = position
		explosion.damage = 50
		add_sibling(explosion)
		queue_free()
