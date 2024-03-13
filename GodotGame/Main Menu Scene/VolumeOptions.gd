extends HSlider


@export
var bus_name: String # might be better to just have local variables
var bus_index: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	value = db_to_linear(AudioServer.get_bus_index(bus_name))

func _on_value_changed(v: float) -> void:
	print("new slider value: ", v, " + index: ", bus_index)
	
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(v / 100)
	)
	
	$SFXVolumeValueLabel.text = str(v) + "%"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
