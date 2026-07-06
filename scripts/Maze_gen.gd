extends Node


class_name maze_gen

var width : int

var hieght :int

var grid : Array =[]

func generate(w:int,h:int) -> Array:
	width = w
	hieght = h
	
	grid = []
	for y in range(hieght) :
		var row =[]
		for x in range(width):
			row.append(true)
		grid.append(row)
		
	_crave(1,1)
	return grid
		
func _crave(x:int,y:int) -> void:
	grid[y][x] =false
	var direction = [Vector2i(0,-2),Vector2i(0,2),Vector2i(-2,0),Vector2i(2,0)]
	direction.shuffle()
	
	for i in direction:
		var nx = x + i.x
		var ny = y+ i.y
		
		if nx  > 0 and nx < width -1 and ny > 0 and ny < hieght-1 and grid[ny][nx] :
			grid[y + i.y / 2][ x+ i.x /2] = false
			
			_crave(nx,ny)
