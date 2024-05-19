@tool
extends Node2D

#@export var variable: int = 5
@export_enum("apple", "bananas", "cherries") var fruitType: String = "apple":
	set(value):
		fruitType = value
		$animationFruit.animation = fruitType
		print(value)
# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		$animationFruit.play(fruitType)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_collect_fruit_body_entered(body):
	print("Toco la fruta: ", body.name)
	if  body.name == "ninja_frog":
		#body.fruitCount += 1
		#print(body.fruitCount)
		if body.has_method("collectFruit"):
			body.collectFruit(fruitType)
			
	$animationFruit.play("collected")
	pass # Replace with function body.


func _on_animation_fruit_animation_finished():
	#queue_free quita la escena
	self.queue_free()	
	pass # Replace with function body.
