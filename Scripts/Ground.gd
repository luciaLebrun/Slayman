extends TileMap

export var startX = -500
export var endX = 500
export var y = 0
var tilesGround = [0, 2, 3, 8]

func addChunk():
	for x in range(startX, endX):
		var rand_value = tilesGround[randi() % tilesGround.size()]
		self.set_cell(x,y,rand_value)
		self.set_cell(x,y+1,5)

# Called when the node enters the scene tree for the first time.
func _ready():
	addChunk()
	print(self.position.y)
