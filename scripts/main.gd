extends Node2D


const c_size = 24
const m_width = 21
const m_hieght = 21


var orbsleft = 0

var m_gen :maze_gen

var data :Array

var echo_time = 6
var echospawned = false


func _ready() -> void:
	m_gen = maze_gen.new()
	data = m_gen.generate(m_width,m_hieght)
	print("kk")
	
	mazedraw()
	$CharacterBody2D.position = Vector2(c_size + c_size/2.0,c_size + c_size /2.0 )
	spawnorbs()
	
	
func _process(delta: float) -> void:
	if not echospawned and $CharacterBody2D.pos_history.size() > 0:
		if $CharacterBody2D.pos_history.size() *.1 >echo_time :
			echospawn()
			echospawned = true
			
	
func mazedraw() :
	for y in range(m_hieght):
		for x in range(m_width):
			if data[y][x]:
				var wall = ColorRect.new()
				wall.size = Vector2(c_size,c_size)
				wall.position = Vector2(x*c_size,y*c_size)
				wall.color = Color(4.525, 4.525, 11.708, 1.0)
				$mazecontainer.add_child(wall)
	
				var wallbody = StaticBody2D.new()
				wallbody.position =  Vector2(x*c_size,y * c_size)
			
				var collisonshape =CollisionShape2D.new()
				var shape = RectangleShape2D.new()
				shape.size = Vector2(c_size,c_size)
				collisonshape.shape = shape
				collisonshape.position = Vector2(c_size / 2.0 , c_size /2.0 )
				wallbody.add_child(collisonshape)
				$mazecontainer.add_child(wallbody)
			
	


func spawnorbs() :
	for y in range(m_hieght) :
		for x in range(m_width) :
			if not data[y][x] :
				if x == 1 and y == 1 :
					continue
				var orbsarea = Area2D.new()
				
				orbsarea.position = Vector2( x*c_size + c_size/2.0   , y * c_size +c_size/2.0 )
				orbsarea.add_to_group("orbs")
				
				var visuals = ColorRect.new()
				visuals.size = Vector2(4,4)
				visuals.position = Vector2( -2,-2)
				
				
				visuals.color=Color(1,.9,1)
				
				orbsarea.add_child(visuals)
				
				var shape = CollisionShape2D.new()
				var circle = CircleShape2D.new()
				shape.shape = circle
				circle.radius = 4
				orbsarea.add_child(shape)
				
				
				$mazecontainer.add_child(orbsarea)
				orbsleft -=1 
				
				
func echospawn():
	var echo = ColorRect.new()
	echo.size = Vector2(20,20)
	echo.color = Color(1,0,0,)
	echo.name = "ECHO"
	$mazecontainer.add_child(echo)
	echo.set_meta("playback_index",0)
	echo.set_meta("isecho",0)
	
	
func echomove() :
	var echo = $mazecontainer.get_node_or_null("ECHO")
	if echo ==null:
		return
	var history = $CharacterBody2D.pos_history
	
	var index = echo.get_meta("playback_index")
		
		
	if index < history.size() :
		echo.position = history[index]
		echo.set_meta("playback_index",index+1)
	else:
		echo.set_meta("playback_index",0)
		
