extends CharacterBody2D


const speed = 150 
var pos_history : Array = []

const history_intervel = .1
var his_timmer = 0.0
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
		
	his_timmer += delta
	if his_timmer >= history_intervel :
		his_timmer = 0
		pos_history.append(position)
		
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("orbs"):
		
		area.queue_free()
		get_parent().orbsleft -=1
		get_parent().checkwin()
	if area.is_in_group("echo"):
		get_tree().change_scene_to_file("res://mainmenu.tscn")
		
