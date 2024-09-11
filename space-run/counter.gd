extends RichTextLabel

var SurvivedTime = 0

func SurviveTimer():
	await get_tree().create_timer(1).timeout
	SurvivedTime += 1
	UpdateLabel()
	if $"../Player".alive:
		SurviveTimer()
	
func  UpdateLabel():
	$".".text = "Score: "+str(SurvivedTime)
	
func _ready() -> void:
	SurviveTimer()
