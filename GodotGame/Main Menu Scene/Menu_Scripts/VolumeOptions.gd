extends HSlider
@onready var vol_label = get_node("SFXVolumeValueLabel")
var fix_vol_temp = false

@export
var bus_name: String # might be better to just have local variables
var bus_index: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	value = db_to_linear(AudioServer.get_bus_index(bus_name))
	
func _on_value_changed(v: float) -> void:
	if not fix_vol_temp:
		fix_vol_temp = true
		v = 100
		$".".value = v
	#print("[slider] bus index: ", bus_index)
	
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(v / 100)
	)
	
	vol_label.text = str(v) + "%"
	#print(str(bus_index)+":"+str(v))
