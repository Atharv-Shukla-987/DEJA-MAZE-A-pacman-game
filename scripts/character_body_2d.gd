extends CharacterBody2D


const speed = 150 


func _ready() -> void:
	$ColorRect.size = Vector2(20,20)
	print("hello")
	$Area2D.area_entered.connect(_on_area_2d_area_entered)

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	var inputdir = Vector2.ZERO
	
	
	if Input.is_action_pressed("left"):
		
		inputdir.x = -1
	if Input.is_action_pressed("rifht"):
		inputdir.x = 1  

	if Input.is_action_pressed("down"):
		inputdir.y = 1
		
	if Input.is_action_pressed("up"):
		inputdir.y =-1
		
		
	
	velocity = inputdir * speed
	move_and_slide()  


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("orbs"):
		print("kk")
		area.queue_free()
		get_parent().orbsleft -=1
		
