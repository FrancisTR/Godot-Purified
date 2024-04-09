extends HSlider
@onready var vol_label = get_node("SFXVolumeValueLabel")

@export
var bus_name: String
var bus_index: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)

	value_changed.connect(_on_value_changed)
	value = get_volume()
	
func _on_value_changed(v: float) -> void:
	#print("[slider] bus index: ", bus_index)
	
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(v / 100)
	)
	
	vol_label.text = str(get_volume()) + "%"
	#print(str(bus_index)+":"+str(v))

func get_volume() -> int:
	return int(db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)) * 100)
