extends Sprite2D

@export var texto:String = "":
	set(value):
		print("Setting texto to: ", value)  # Debug print
		visible = true
		texto = value
		$Timer.start()

var index = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	if index >= texto.length():
		print(index)
		$Timer_escondeB.start()
		$Timer.stop()
		
	else:
		$Label.text = $Label.text + texto[index]
		index += 1


func _on_timer_esconde_b_timeout():
	visible = false
	$Label.text = ""
	index = 0
