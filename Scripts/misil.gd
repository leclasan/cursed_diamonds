extends Area2D

var speed = 500
var direction

var damage = 0

var explosion_scene = preload("res://Scenes/explosion.tscn")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.x += speed * delta * direction
	if direction == -1:
		$Sprite2D.flip_h = true


func _on_area_entered(area: Area2D) -> void:
	if not area.is_in_group("Weapons"):
		if not area.is_in_group("EnemyWeapons"):
			if not area.is_in_group("Diamonds"):
				var explosion = explosion_scene.instantiate()
				explosion.position = position
				add_sibling(explosion)
				queue_free()


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Players"):
		var explosion = explosion_scene.instantiate()
		explosion.position = position
		add_sibling(explosion)
		queue_free()
