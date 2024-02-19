extends Node2D

@export var day:int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func increase_day(amount):
	if(day+amount > 0):
		day += amount

func open_leave_menu():
	$UI/LeaveVillage.show()

#**********TEST BUTTONS***********#
func _on_test_inc_1():
	print("+")
	increase_day(1)

func _on_test_dec_1():
	print("-")
	increase_day(-1)


