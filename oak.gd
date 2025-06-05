extends Area2D

@export var type = "tree"
@export var tile_map :TileMapLayer = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func extract():
	tile_map.erase_cell(tile_map.local_to_map(position))
