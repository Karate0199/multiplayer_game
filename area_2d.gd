extends Area2D

@export var tupe = "godot"
@onready var tile_map :TileMapLayer = get_parent()


func extract():
	tile_map.erase_cell(tile_map.local_to_map(position))
