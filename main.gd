extends Node
@export var circle_scene : PackedScene
@export var cross_scene : PackedScene

var temp_marker
var player_panel_pos : Vector2i
var player : int
var grid_data : Array
var grid_pos : Vector2i
var board_size: int
var cell_size : int

# Called when the node enters the scene tree for the first time.
func _ready():
	board_size = $Board.texture.get_width()
	#divide board size by three to get the size of individual cell
	cell_size = board_size / 3
	#get coordinates of small panel on the right side of the window
	player_panel_pos = $PlayerPanel.get_position()
	new_game()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var local_pos = $Board.get_local_mouse_position() + Vector2(board_size / 2, board_size / 2)
			if local_pos.x >= 0 and local_pos.x < board_size and local_pos.y >= 0 and local_pos.y <board_size:
					#convert mouse position into grid location
				grid_pos = Vector2i(local_pos / cell_size)
				if grid_data[grid_pos.y][grid_pos.x] == 0:
					grid_data [grid_pos.y][grid_pos.x] = player
					#place that players marker
					var cell_center = Vector2(grid_pos * cell_size) + Vector2(cell_size / 2, cell_size / 2)
					var spawn_pos = cell_center - Vector2(board_size / 2, board_size /2)
					create_marker(player, spawn_pos)
					player *= -1
					print (grid_data)

	
func new_game():
	player = 1
	grid_data = [[0,0,0],[0,0,0],[0,0,0]]
	#create a marker to show starting player's turn
	

func create_marker(player, position, temp=false):
	#create a marker node and add it as a child
	if player == 1:
		var circle = circle_scene.instantiate()
		circle.position = position
		circle.scale = Vector2(0.12,0.12)
		$Board.add_child(circle)
		if temp: temp_marker = circle
	else:
		var cross = cross_scene.instantiate()
		cross.position = position
		cross.scale = Vector2(0.12,0.12)
		$Board.add_child(cross)
		if temp : temp_marker = cross
