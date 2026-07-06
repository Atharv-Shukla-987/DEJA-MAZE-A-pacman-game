extends Node2D


const c_size = 24
const m_width = 21
const m_hieght = 21


var m_gen :maze_gen

var data :Array



func _ready() -> void:
	m_gen = maze_gen.new(
		
	)
	data = m_gen.generate(m_width,m_hieght)
	
	mazedraw()
	
	
func mazedraw() :
	for y in range(m_hieght):
		for x in range(m_width):
			if data[y][x]:
				var wall = ColorRect.new()
				wall.size = Vector2(c_size,c_size)
				wall.position = Vector2(x*c_size,y*c_size)
				wall.color = Color(4.525, 4.525, 11.708, 1.0)
				$mazecontainer.add_child(wall)
	
			var wallbody = StaticBody2D.new(
				
			)
			wallbody.position =  Vector2(x*c_size,y * c_size)
			
			var collisonshape =CollisionShape2D.new()
			var shape = RectangleShape2D.new()
			shape.size = Vector2(c_size,c_size)
			collisonshape.shape = shape
			collisonshape.position = Vector2(c_size / 2.0 , c_size /2.0 )
			wallbody.add_child(collisonshape)
			$mazecontainer.add_child(wallbody)
			
	
