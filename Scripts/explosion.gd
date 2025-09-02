extends Area2D

var damage = 150



func _on_child_exiting_tree(node: Node) -> void:
	queue_free()
