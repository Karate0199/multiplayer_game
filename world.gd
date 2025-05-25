extends Node2D


@export var noise_height_texct :NoiseTexture2D
@export var noise_tree_texct :NoiseTexture2D
var noise :Noise
var tree_noise :Noise

var width :int = 256
var height :int = 256

var water_atlas = Vector2i(11, 0)
var grass_tile_arr = []
var terrian_grass_int = 0
var grass_atlas_arr = [Vector2i(7, 1),Vector2i(7, 2),Vector2i(8, 1),Vector2i(8, 2),Vector2i(9, 1),Vector2i(9, 2)]

var thread :Thread

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	thread = Thread.new()
	thread.start(_on_save_world)

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
