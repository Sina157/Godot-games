extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(4).timeout
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= 10


func _on_bullet_area_area_entered(area: Area2D) -> void:
		if area.name == "stone_area":
			queue_free()
