extends Node2D

@onready var stone = preload("res://objects/stone.tscn")
var rng = RandomNumberGenerator.new()
var delay = 1.8
var RocksSpeed = 1




	
func spawn_rocks():
	var random_number = rng.randf_range(20, 580)
	var obj = stone.instantiate()
	obj.position.x = random_number
	obj.position.y = -25
	obj.speed = RocksSpeed
	add_child(obj)
	await get_tree().create_timer(delay).timeout
	spawn_rocks()

func _ready() -> void:
	spawn_rocks()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_harder_timeout() -> void:
	if delay > 0.2:
		delay -= 0.05
	RocksSpeed += 0.075
