extends Node2D

var enterBody = false


var craftingList:Dictionary
var ItemOfTheDay
var itemImage
@onready var listText = [
	$UI/CraftingList/ItemList/ItemBox/Item,
	$UI/CraftingList/ItemList/ItemBox2/Item2,
	$UI/CraftingList/ItemList/ItemBox3/Item3,
	$UI/CraftingList/ItemList/ItemBox4/Item4
]
@onready var listTextNumber = [
	$UI/CraftingList/ItemList/ItemBox/Item/ItemText, 
	$UI/CraftingList/ItemList/ItemBox2/Item2/Item2Text,
	$UI/CraftingList/ItemList/ItemBox3/Item3/Item3Text,
	$UI/CraftingList/ItemList/ItemBox4/Item4/Item4Text
]
@onready var listTextImg = [
	$UI/CraftingList/ItemList/ItemBox/ItemImg, 
	$UI/CraftingList/ItemList/ItemBox2/ItemImg2,
	$UI/CraftingList/ItemList/ItemBox3/ItemImg3,
	$UI/CraftingList/ItemList/ItemBox4/ItemImg4
]
var listKeys
var listValues


func _ready():
	$UI/CraftingList.visible = false
	
	#TODO Add crafting recipes
	if GameData.day == 2:
		craftingList = {"Twig": 6, "TinCan": 1}
		listKeys = craftingList.keys()
		listValues = craftingList.values()
		ItemOfTheDay = "BoilingPot"
		$UI/CraftingList/ShowItemCrafted/ItemHint.texture = load("res://Assets/Custom/Items/BoilingPotHidden.png")
		itemImage = load("res://Assets/Custom/Items/BoilingPot.png")

	elif GameData.day == 3 or GameData.day == 8:
		craftingList = {"WaterBottle": 1, "Sand": 2, "Rock": 2, "Moss": 2}
		listKeys = craftingList.keys()
		listValues = craftingList.values()
		ItemOfTheDay = "WaterFilter"
		$UI/CraftingList/ShowItemCrafted/ItemHint.texture = load("res://Assets/Custom/Items/WaterFilterHidden.png")
		itemImage = load("res://Assets/Custom/Items/WaterFilter.png")

		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (GameData.day != 1):
		#TODO: (in case) List of items needed in UI
		for i in range(0, len(craftingList)):
			listText[i].text = str(listKeys[i])
			
			#How many items the player has in order to craft?
			if (GameData.inventory_amount.keys().find(listKeys[i]) != -1):
				listTextNumber[i].text = str(GameData.inventory_amount[listKeys[i]]) + "/" + str(listValues[i])
			else:
				listTextNumber[i].text = "0/" + str(listValues[i])
			
			
			#add textures for the player to see on the list
			if listKeys[i] == "Twig":
				listTextImg[i].texture = load("res://Assets/Custom/Items/Twig.png")
			elif listKeys[i] == "TinCan":
				listTextImg[i].texture = load("res://Assets/Custom/Items/TinCan.png")
			elif listKeys[i] == "WaterBottle":
				listTextImg[i].texture = load("res://Assets/Custom/Items/WaterBottle.png")
			elif listKeys[i] == "Sand":
				listTextImg[i].texture = load("res://Assets/Custom/Items/Sand.png")
			elif listKeys[i] == "Rock":
				listTextImg[i].texture = load("res://Assets/Custom/Items/Rock.png")
			elif listKeys[i] == "Moss":
				listTextImg[i].texture = load("res://Assets/Custom/Items/Moss.png")
				
	else:
		$UI/CraftingList/CraftButton.visible = false
		
		
		
	if Input.is_action_just_pressed("StartDialogue") and enterBody == true:	
		if GameData.current_ui != "Crafting" && GameData.current_ui != "":
			return
		GameData.charLock = true
		GameData.current_ui = "Crafting"
		$UI/CraftingList.visible = true
		$PressInteraction.visible = false
		#Enable the crafting button if met
		listKeys = craftingList.keys()
		listValues = craftingList.values()
		var count = 0
		
		#See if there are enough items to craft. If so, show craft button
		for i in range(0, len(listKeys)):
			if (GameData.inventory_amount.keys().find(listKeys[i]) != -1):
				if GameData.inventory_amount[listKeys[i]] >= craftingList[listKeys[i]]:
					count = count + 1
			
		if count == len(listKeys):
			$UI/CraftingList/CraftButton.disabled = false
		else:
			$UI/CraftingList/CraftButton.disabled = true
		


func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		print("Entered crafting")
		$PressInteraction.visible = true
		$UI/CraftingList.visible = false
		enterBody = true



func _on_body_exited(body):
	if (body.name == "CharacterBody2D"):
		$PressInteraction.visible = false
		$UI/CraftingList.visible = false
		enterBody = false
		print("Exit crafting")
		GameData.current_ui = ""



func _on_craft_button_pressed():
		SoundControl.is_playing_sound("crafted")
		print("Crafted!")
		# For Day 8 Only	
		if ItemOfTheDay == "WaterFilter":
			GameData.itemDialogue[4]["Value"] = GameData.itemDialogue[4]["Value"] + 1
		
		if GameData.day <= 3:
			GameData.questComplete["Wild"] = true
		
		for i in range(0, len(listKeys)):
			Utils.remove_from_inventory(str(listKeys[i]), int(craftingList[listKeys[i]]))
		Utils.add_to_inventory(str(ItemOfTheDay), 1)
		$UI/CraftingList.visible = false
		
		
		$UI/CraftedItem.visible = true
		#TODO add what item the player made along with an image
		$UI/CraftedItem/ColorRect/ItemName.text = ItemOfTheDay
		$UI/CraftedItem/ColorRect/ItemImage.texture = itemImage




func _on_okay_button_pressed():
	$UI/CraftedItem.visible = false
	GameData.charLock = false
	GameData.current_ui = ""
	SoundControl.is_playing_sound("button")


func _on_x_button_pressed():
	$UI/CraftingList.visible = false
	GameData.charLock = false
	$PressInteraction.visible = true
	GameData.current_ui = ""
	SoundControl.is_playing_sound("button")
