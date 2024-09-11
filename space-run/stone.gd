extends AnimatedSprite2D

@onready var anim = $"."
var speed
func _ready() -> void:
	anim.play()


	
func _process(delta: float) -> void:
		position.y += speed


func _on_stone_area_area_entered(area: Area2D) -> void:
	if area.name == "bullet_area":
			$"../Rocksmash".play()
			$"../Counter".SurvivedTime += 1
			$"../Counter".UpdateLabel()
			queue_free()


func _on_timer_timeout() -> void:
	queue_free()
