extends AnimatedSprite2D
@onready var anim = $"."
var bullet = preload("res://objects/bullet.tscn")
var CanShot = true
var PlayerMoveSpeed = 5
var alive = true
var isMobile = true

func save_data(data) -> void:
	var file = FileAccess.open("user://Data.save", FileAccess.WRITE)
	file.store_var(data)
	file.close()

func load_data():
	var file = FileAccess.open("user://Data.save", FileAccess.READ)
	var res = file.get_var()
	file.close()
	return res

func _ready() -> void:
	if typeof(load_data()) != 2:
		save_data(0)
	anim.play()

func FireBullet():
	if CanShot and alive:
		var obj = bullet.instantiate()
		obj.position.x = anim.position.x
		obj.position.y = anim.position.y - 15
		get_window().add_child.call_deferred(obj)
		CanShot = false
		$shoot_delay.start()
		$AudioStreamPlayer2D.play()

func _process(delta: float):
	if not alive:
		return
	anim.animation = "idle"
	if isMobile:
		#var VerticalMove =  $"../Joystick".posVector[1] * 4
		#var HorizontalMove = $"../Joystick".posVector[0] * 4
		#position.x += HorizontalMove
		#position.y += VerticalMove
		#if HorizontalMove > 0: anim.animation = "moveLeft"
		#elif  HorizontalMove < 0: anim.animation = "moveRight"
		var TouchPos = $"../TouchScreen".TouchPos
		if  TouchPos.x - position.x < 0:
			position.x -= PlayerMoveSpeed
		elif TouchPos.x - position.x > 6:
			position.x += PlayerMoveSpeed
		if  TouchPos.y - position.y < 0:
			position.y -= PlayerMoveSpeed
		elif TouchPos.y - position.y > 5:
			position.y += PlayerMoveSpeed 
	else:
		if (Input.is_action_pressed("MoveLeft") or Input.is_action_pressed("ui_left")) :
			anim.animation = "moveRight"
			anim.frame = 0
			position.x -= PlayerMoveSpeed
		if (Input.is_action_pressed("MoveRight") or Input.is_action_pressed("ui_right")) :
			anim.animation = "moveLeft"
			anim.frame = 0
			position.x += PlayerMoveSpeed
		if (Input.is_action_pressed("MoveDown") or Input.is_action_pressed("ui_down")) :
			position.y += PlayerMoveSpeed
		if (Input.is_action_pressed("MoveUp") or Input.is_action_pressed("ui_up")) :
			position.y -= PlayerMoveSpeed
		if Input.is_action_just_pressed("fire"):
			FireBullet()
	if position.x < 35:
		position.x = 35
	if position.x > 565:
		position.x = 565
	if position.y < 60:
		position.y = 60
	if position.y > 665:
		position.y = 665



func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if area.name == "stone_area" and alive:
		$"../PlayerDie".play()
		alive = false
		anim.animation = "die"
		await get_tree().create_timer(2).timeout
		var LastRecord = load_data()
		var record = $"../Counter".SurvivedTime
		if LastRecord < record:
			save_data(record)
			$"../GameOverPanel/NewRecord".visible = true
			$"../GameOverPanel/Label".text = "your highest record was "+ str(LastRecord)
		else:
			$"../GameOverPanel/Label".text = "your highest record is "+ str(LastRecord)
		$"../GameOverPanel/RecordNumber".text = str(record)
		$"../GameOverPanel".visible = true




func _on_shoot_delay_timeout() -> void:
	CanShot = true
