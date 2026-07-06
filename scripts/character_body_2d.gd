extends CharacterBody2D


const speed = 150 


func _ready() -> void:
	$ColorRect.size = Vector2(20,20)


func _physics_process(delta: float) -> void:
	var inputdir = Vector2.ZERO
	
	
	if Input.is_action_pressed("ui_left"):
		inputdir.x = -1
	if Input.is_action_pressed("ui_right"):
		inputdir.x = 1  

	if Input.is_action_pressed("ui_down"):
		inputdir.y = 1
		
	if Input.is_action_pressed("ui_up"):
		inputdir.y =-1
		
		
		
	velocity = inputdir * speed
	move_and_slide() 
