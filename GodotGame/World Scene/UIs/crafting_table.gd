extends Node2D

var enterBody = false
var CTtype = "" # Two different crafting tables

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
	$PressInteraction.text = RemapperData.get_keymap_name("Interaction")
	$UI/CraftingList.visible = false
	
	#Well is fixed after day 8
	if GameData.day > 8 and $"../Well/Sprite2D" != null:
		$"../Well/Sprite2D".texture = load("res://Assets/Custom/Wells.png")
	
	#TODO Add crafting recipes
	if GameData.day == 2:
		craftingList = {"Twig": 6, "TinCan": 1}
		listKeys = craftingList.keys()
		listValues = craftingList.values()
		ItemOfTheDay = "BoilingPot"
		$UI/CraftingList/ShowItemCrafted/ItemHint.texture = load("res://Assets/Custom/Items/BoilingPotHidden.png")
		itemImage = load("res://Assets/Custom/Items/BoilingPot.png")

	elif GameData.day == 3:
		craftingList = {"WaterBottle": 1, "Sand": 2, "Rock": 2, "Moss": 2}
		listKeys = craftingList.keys()
		listValues = craftingList.values()
		ItemOfTheDay = "WaterFilter"
		$UI/CraftingList/ShowItemCrafted/ItemHint.texture = load("res://Assets/Custom/Items/WaterFilterHidden.png")
		itemImage = load("res://Assets/Custom/Items/WaterFilter.png")

		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameData.day == 7 and GameData.villagersTalked[6]["Talked"] == true:
		craftingList = {"WaterBottle": 2, "Sand": 3, "Moss": 3, "Rock": 2}
		listKeys = craftingList.keys()
		listValues = craftingList.values()
		ItemOfTheDay = "ReverseOsmosis"
		$UI/CraftingList/ShowItemCrafted/ItemHint.texture = load("res://Assets/Custom/Items/ROShadow.png")
		itemImage = load("res://Assets/Custom/Items/RO.png")
	
	#Crafting table or Well Crafting
	if GameData.day == 8 and CTtype != "Well" and GameData.day_8_count < 2:
		craftingList = {"WaterBottle": 1, "Sand": 2, "Rock": 2, "Moss": 2}
		listKeys = craftingList.keys()
		listValues = craftingList.values()
		ItemOfTheDay = "WaterFilter"
		$UI/CraftingList/ShowItemCrafted/ItemHint.texture = load("res://Assets/Custom/Items/WaterFilterHidden.png")
		itemImage = load("res://Assets/Custom/Items/WaterFilter.png")
	if GameData.day == 8 and CTtype == "Well":
		#Well Recipe
		craftingList = {"Twig": 5, "Rock": 5}
		listKeys = craftingList.keys()
		listValues = craftingList.values()
		ItemOfTheDay = "Well"
		$UI/CraftingList/ShowItemCrafted/ItemHint.texture = load("res://Assets/Custom/WellsShadow.png")
		itemImage = load("res://Assets/Custom/Wells.png")
	
	
	if ((GameData.day == 7 and GameData.villagersTalked[6]["Talked"] == false) or GameData.day == 9 or GameData.day == 10):
		$UI/CraftingList/CraftButton.visible = false
	elif (GameData.day != 1):
		#Clear everything first
		#Make it dynamic
		for i in range(len(listText)):
			listText[i].text = ""
			listTextNumber[i].text = ""
			listTextImg[i].texture = null
		
		
		
		
		$UI/CraftingList/CraftButton.visible = true
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
	
	if GameData.day == 8:
		if GameData.day_8_count >= 2 and CTtype != "Well":
			$UI/CraftingList/CraftButton.visible = false
		else:
			$UI/CraftingList/CraftButton.visible = true
		
	if Input.is_action_just_pressed("Interaction") and enterBody == true:	
		#if (self.name == "CraftingTablePRIME"):
			#print("Dark ruler no more")
			#return
		if GameData.current_ui != "Crafting" && GameData.current_ui != "":
			return
		GameData.charLock = true
		GameData.current_ui = "Crafting"
		
		
		#If it is the old man crafting bench, prompt to not use it until it is the right time
		if CTtype == "CraftingTablePRIME" and GameData.day < 7:
			$UI/OldMan.visible = true
			$PressInteraction.visible = false
		elif CTtype == "Well" and GameData.day < 8: #Well Broke
			$UI/BrokenWell.visible = true
			$PressInteraction.visible = false
		elif (CTtype == "Well" and GameData.day > 8) or (GameData.well == true and CTtype == "Well"): #Well not broke
			$UI/Well.visible = true
			$PressInteraction.visible = false
		elif CTtype == "Well" and GameData.day == 8: #Well Crafing to fix it
			
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
				$UI/CraftingList/CraftButton.text = "Rebuild"
				$UI/CraftingList/CraftButton.disabled = false
			else:
				$UI/CraftingList/CraftButton.text = "Rebuild"
				$UI/CraftingList/CraftButton.disabled = true
		
		
		else:
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
		CTtype = self.name



func _on_body_exited(body):
	if (body.name == "CharacterBody2D"):
		$PressInteraction.visible = false
		$UI/CraftingList.visible = false
		$UI/OldMan.visible = false
		$UI/BrokenWell.visible = false
		$UI/Well.visible = false
		enterBody = false
		print("Exit crafting")
		GameData.current_ui = ""
		CTtype = ""



func _on_craft_button_pressed():
		SoundControl.is_playing_sound("crafted")
		print("Crafted!")
		# For Day 8 Only	
		if GameData.day == 8 and ItemOfTheDay == "WaterFilter":
			GameData.day_8_count = GameData.day_8_count + 1
		if ItemOfTheDay == "WaterFilter":
			GameData.itemDialogue[4]["Value"] = GameData.itemDialogue[4]["Value"] + 1
		
		if GameData.day <= 3:
			GameData.questComplete["Wild"] = true
		
		#Remove items that is used for crafting
		for i in range(0, len(listKeys)):
			Utils.remove_from_inventory(str(listKeys[i]), int(craftingList[listKeys[i]]))
		
		if ItemOfTheDay != "Well":
			Utils.add_to_inventory(str(ItemOfTheDay), 1)
		if ItemOfTheDay == "Well":
			#Global Var that we rebuilt the well.
			GameData.well = true
			print("rebuilt!")
			#Change the sprite of the Well to fixed dynamically
			$"../Well/Sprite2D".texture = load("res://Assets/Custom/Wells.png")
			pass
		$UI/CraftingList.visible = false
		
		
		$UI/CraftedItem.visible = true
		#TODO add what item the player made along with an image
		$UI/CraftedItem/ColorRect/ItemName.text = ItemOfTheDay
		$UI/CraftedItem/ColorRect/ItemImage.texture = itemImage




func _on_okay_button_pressed():
	$UI/CraftedItem.visible = false
	$UI/OldMan.visible = false
	$UI/BrokenWell.visible = false
	$UI/Well.visible = false
	SoundControl.is_playing_sound("button")
	GameData.charLock = false
	GameData.current_ui = ""


func _on_x_button_pressed():
	$UI/CraftingList.visible = false
	GameData.charLock = false
	$PressInteraction.visible = true
	GameData.current_ui = ""
	SoundControl.is_playing_sound("button")
