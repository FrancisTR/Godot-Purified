extends Node

const SAVE_PATH = "users://savegame.bin"

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data = {
	}
	
	
func load_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
