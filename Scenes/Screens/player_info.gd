extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().get_node("ninja_frog"):
		$ProgressBar.value = get_parent().get_node("ninja_frog").healt
		$FruitPointsLabel.text = "Frutas: " + str(get_parent().get_node("ninja_frog").fruitCount)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressBar.value = get_parent().get_node("ninja_frog").healt
	$FruitPointsLabel.text = "Frutas: " + str(get_parent().get_node("ninja_frog").fruitCount)
	
	if Time.get_time_dict_from_system().hour > 12 :
		$Clock.text = str(Time.get_time_dict_from_system().hour - 12) + " : " + str(Time.get_time_dict_from_system().minute) + " : " + str(Time.get_time_dict_from_system().second) 
	else:
		$Clock.text = str(Time.get_time_dict_from_system().hour) + " : " + str(Time.get_time_dict_from_system().minute) + " : " + str(Time.get_time_dict_from_system().second) 
	#print(Time.get_time_dict_from_system())
	pass
