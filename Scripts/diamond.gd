extends Area2D

var bos_2 = false

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		if bos_2:
			get_parent().points += 50
			$"../../Player".change_weapon()
			get_parent().spawn_diamond()
			queue_free()
		else:
			get_parent().points += 50
			$"../Player".change_weapon()
			get_parent().spawn_diamond()
			queue_free()
