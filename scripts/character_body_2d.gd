extends CharacterBody2D


const speed = 150 


func _ready() -> void:
	$ColorRect.size = Vector2(20,20)
	print("hello")

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	var inputdir = Vector2.ZERO
	
	
	if Input.is_action_pressed("left"):
		print("hello")
		inputdir.x = -1
	if Input.is_action_pressed("rifht"):
		inputdir.x = 1  

	if Input.is_action_pressed("down"):
		inputdir.y = 1
		
	if Input.is_action_pressed("up"):
		inputdir.y =-1
		
		
	print(inputdir,velocity)
	velocity = inputdir * speed
	move_and_slide()  
