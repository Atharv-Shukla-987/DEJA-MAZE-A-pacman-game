extends Node2D


const c_size = 24
const m_width = 21
const m_hieght = 21

var totalorbs = 0
var orbsleft = 0

var m_gen :maze_gen

var data :Array

var echo_time = 6
var echospawned = false

var echo_playback_timr = 0.0
var playback_interval = .1

func _ready() -> void:
	m_gen = maze_gen.new()
	data = m_gen.generate(m_width,m_hieght)
	
	
	mazedraw()
	$CharacterBody2D.position = Vector2(c_size + c_size/2.0,c_size + c_size /2.0 )
	spawnorbs()
	
	
func _process(delta: float) -> void:
	
	if not echospawned and $CharacterBody2D.pos_history.size() > 0:
		if $CharacterBody2D.pos_history.size() *.1 >echo_time :
			echospawn()
			echospawned = true
			
	if echospawned:
		echomove()
			
	
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
				orbsleft +=1
				totalorbs = orbsleft 
				
				
func echospawn():
	var echo = Area2D.new()
	
	echo.name = "Echo"
	
	echo.add_to_group("echo")
	var visual = ColorRect.new()
	visual.size = Vector2(20,20 )
	visual.position = Vector2(-10,-10)
	
	visual.color = Color(1,0,0)
	echo.add_child(visual)
	
	var shape = CollisionShape2D.new()
	var rec_shape = RectangleShape2D.new()
	rec_shape.size = Vector2(20,20)
	shape.shape = rec_shape
	echo.add_child(shape)
	
	$mazecontainer.add_child(echo)
	
	echo.set_meta("playback_index",0)
	
	
func echomove() :
	var echo = $mazecontainer.get_node_or_null("Echo")
	if echo ==null:
		
		return
		
	echo_playback_timr += get_process_delta_time()
	if echo_playback_timr< playback_interval:
		return
	echo_playback_timr = 0
	
	var history = $CharacterBody2D.pos_history
	
	var index = echo.get_meta("playback_index")
	print("echo imdex" ,index," / history size :",history.size(),"echo pos " ,echo.position)
		
	if index < history.size() :
		echo.position = history[index]
		echo.set_meta("playback_index",index+1)
	else:
		echo.set_meta("playback_index",0)
		

func checkwin():
	if totalorbs == 0:
		return
	var eaten = totalorbs-orbsleft
	if eaten >= totalorbs*.8:
		get_tree().reload_current_scene()
