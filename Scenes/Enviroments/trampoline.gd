extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_activation_area_body_entered(body):
	print(body.name)
	if body.name == "ninja_frog":
		$animation_trampoline.play("launch")
		body.velocity.y = -800
		#print(body.name)
