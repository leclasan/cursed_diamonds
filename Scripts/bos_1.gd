extends Area2D

var life = 1000

var bullet_scene = preload("res://Scenes/bos_1_bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if life <= 0:
		queue_free()
		PlayerStats.points += 500
		get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		PlayerStats.lives -= 1
		$"../Player".global_position = Vector2(81, 563)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Weapons"):
		life -= area.damage


func _on_attack_timer_timeout() -> void:
	var random_number = randi_range(1, 100)
	if random_number >= 50:
		var bullet = bullet_scene.instantiate()
		bullet.position = global_position
		add_sibling(bullet)
	if random_number <= 25:
		var bullet = bullet_scene.instantiate()
		bullet.position = global_position
		bullet.old_speed = Vector2.UP * 3
		bullet.velocity = 220
		add_sibling(bullet)
		bullet = bullet_scene.instantiate()
		bullet.position = global_position
		bullet.old_speed = Vector2.DOWN * 3
		bullet.velocity = 220
		add_sibling(bullet)
		bullet = bullet_scene.instantiate()
		bullet.position = global_position
		bullet.old_speed = Vector2.LEFT * 3
		bullet.velocity = 220
		add_sibling(bullet)
		bullet = bullet_scene.instantiate()
		bullet.position = global_position
		bullet.old_speed = Vector2.RIGHT * 3
		bullet.velocity = 220
		add_sibling(bullet)
	if random_number > 25 and random_number < 50:
		var num_bullets = 30
		for i in num_bullets:
			var bullet = bullet_scene.instantiate()
			bullet.position = global_position
			bullet.old_speed = Vector2.UP.rotated((2 * PI / num_bullets) * i) * 2
			bullet.velocity = 500
			add_sibling(bullet)
			await get_tree().create_timer(0.2).timeout
	$AttackTimer.start()
