extends Node


var day:int = 1

var twigItem = 0

var username = ""

var inventory:Array

var inventory_amount:Dictionary

#What is required to go to the next day
var inventory_requirement:Dictionary

var charLock = false

var current_ui = ""


var visitTutorial = false
var visitedWilderness = false

#Spawn the item once in the wilderness. Prevents duplication
var itemSpawnOnce = false



#Dialogue related stuff
var QMain = false
var QWild = false
#Quest is finished
var questComplete = {"Main": false, "Wild": false}

#TODO Add more if needed to stack of the items needed for NPC
var itemDialogue = [
	{
		"Name": "Twigs",
		"Value": 0
	}
]

var villagersTalked = [
	{
		"Name": "Accept",
		"Talked": false
	},
	{
		"Name": "Anger",
		"Talked": false
	},
	{
		"Name": "Bargin",
		"Talked": false
	},
	{
		"Name": "Croak",
		"Talked": false
	},
	{
		"Name": "Denial",
		"Talked": false
	},
	{
		"Name": "Depress",
		"Talked": false
	},
	{
		"Name": "OldMan",
		"Talked": false
	}
]


#TODO: Testing first then finalize its position
#Spawn only once in the wilderness
#Note that the modification takes place in the wilderness script
#If the item is taken, we record it's pos X and Y and find it in list
#- If we found it, we switch the "Taken" to true, preventing it from spawning again

#Note that this resets in the leavevillage.gd file
var get_item_posX = null
var get_item_posY = null
var itemSpawns = [
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 988,
		"posY": -398,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 1088,
		"posY": -372,
		"Taken": false
	}
]
