extends Node2D


# Called when the node enters the scene tree for the first time.
var craftingList:Dictionary
var ItemOfTheDay
var itemImage
@onready var listText = [
	$CraftingList/ItemList/ItemBox/Item,
	$CraftingList/ItemList/ItemBox2/Item2,
	$CraftingList/ItemList/ItemBox3/Item3,
	$CraftingList/ItemList/ItemBox4/Item4,
	$CraftingList/ItemList/ItemBox5/Item5,
	$CraftingList/ItemList/ItemBox6/Item6,
	$CraftingList/ItemList/ItemBox7/Item7
]
@onready var listTextNumber = [
	$CraftingList/ItemList/ItemBox/Item/ItemText, 
	$CraftingList/ItemList/ItemBox2/Item2/Item2Text,
	$CraftingList/ItemList/ItemBox3/Item3/Item3Text,
	$CraftingList/ItemList/ItemBox4/Item4/Item4Text,
	$CraftingList/ItemList/ItemBox5/Item5/Item5Text,
	$CraftingList/ItemList/ItemBox6/Item6/Item6Text,
	$CraftingList/ItemList/ItemBox7/Item7/Item7Text
]
var listKeys
var listValues

#TODO Add crafting recipes
func _ready():
	$CraftingList.visible = false
	if GameData.day == 2:
		craftingList = {"Twig": 6, "TinCan": 1}
		listKeys = craftingList.keys()
		listValues = craftingList.values()
		ItemOfTheDay = "BoilingPot"
		itemImage = load("res://Assets/profile0.png")
		pass
	elif GameData.day == 3:
		craftingList = {"WaterBottle": 1, "Sand": 2, "Rock": 2, "Moss": 2}
		listKeys = craftingList.keys()
		listValues = craftingList.values()
		ItemOfTheDay = "WaterFilter"
		itemImage = load("res://Assets/WaterFilter.png")
		pass
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (GameData.day != 1):
		#List of items needed in UI
		for i in range(0, len(craftingList)):
			listText[i].text = "" + str(listKeys[i])
			listTextNumber[i].text = "" + str(listValues[i])
	else:
		$CraftingList/CraftButton.visible = false
	pass


func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		print("Entered crafting")
		$CraftingList.visible = true
		
		#Enable the crafting button if met
		listKeys = craftingList.keys()
		listValues = craftingList.values()
		var count = 0
		for i in range(0, len(listKeys)):
			if (GameData.inventory_amount.keys().find(listKeys[i]) != -1):
				if GameData.inventory_amount[listKeys[i]] >= craftingList[listKeys[i]]:
					count = count + 1
		
		if count == len(listKeys):
			$CraftingList/CraftButton.disabled = false
		else:
			$CraftingList/CraftButton.disabled = true
	pass # Replace with function body.


func _on_body_exited(body):
	if (body.name == "CharacterBody2D"):
		$CraftingList.visible = false
		print("Exit crafting")
	pass # Replace with function body.




func _on_craft_button_pressed():
		SoundControl.is_playing_sound("crafted")
		print("Crafted!")
		for i in range(0, len(listKeys)):
			Utils.remove_from_inventory(str(listKeys[i]), int(craftingList[listKeys[i]]))
		Utils.add_to_inventory(str(ItemOfTheDay), 1)
		$CraftingList.visible = false
		
		$CraftedItem.visible = true
		GameData.charLock = true
		#TODO add what item the player made along with an image
		$CraftedItem/ColorRect/ItemName.text = ItemOfTheDay
		$CraftedItem/ColorRect/ItemImage.texture = itemImage





func _on_okay_button_pressed():
	$CraftedItem.visible = false
	GameData.charLock = false
	pass # Replace with function body.
