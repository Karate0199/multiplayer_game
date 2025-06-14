extends Node2D


@export var noise_height_text :NoiseTexture2D
@export var noise_tree_texct :NoiseTexture2D
var noise :Noise
var tree_noise :Noise

var width :int = 256
var height :int = 256

var water_atlas = Vector2i(11, 0)
var grass_tiles_arr = []
var terrian_grass_int = 0
var grass_atlas_arr = [Vector2i(7, 1),Vector2i(7, 2),Vector2i(8, 1),Vector2i(8, 2),Vector2i(9, 1),Vector2i(9, 2)]

var thread :Thread

func _ready() -> void:
	thread = Thread.new()
	thread.start(_on_save_world)
	noise  = noise_height_text.noise
	tree_noise = noise_height_text.noise
	generate_world()
	
	
func generate_world():
	for x in width:
		for y in height:
			var noise_val :float = noise.get_noise_2d(x,y)
			var tree_noise_val :float = tree_noise.get_noise_2d(x,y)
			if noise_val >= 0.0:
				if noise_val > 0.0 and noise_val < 0.5 and  tree_noise_val > 0.0:
					$plants.set_cell(Vector2i(x,y), )
				if noise_val > 0.15:
					$grass.set_cell(Vector2i(x,y), 0,grass_atlas_arr.pick_random())
				grass_tiles_arr.append(Vector2i(x,y))
			$terrian.set_cell(Vector2i(x, y), )
			
	$terrian.set_cells_terrain_connect(grass_tiles_arr, terrian_grass_int, 0)

func _on_save_world():
	while true:
		await get_tree().create_timer(5).timeout
		var node_to_save = self
		var scene = PackedScene.new()
		scene.pack(node_to_save)
		ResourceSaver.save(scene, "user://world.tscn")
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
