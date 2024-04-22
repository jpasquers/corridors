#Tracks the placement of shadows and garrisons onto the TileMap 
#Godot 4's TileMap has abysmal support for maintainting the scene instances...
#We really can't use it for anything beyond the terrain.
class_name GarrisonTileBridge

var tile_map: TileMap;

func _init(in_tile_map: TileMap):
	tile_map = in_tile_map;
