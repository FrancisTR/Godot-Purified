extends Node


var day:int = 7

var twigItem = 0

var username = "l"

var inventory:Array

var inventory_amount:Dictionary

#What is required to go to the next day
var inventory_requirement:Dictionary

var charLock = false
var barryDespawned = false

var current_ui = ""
var current_scene = ""
var save_position = false
var player_position

var visitTutorial = false
var visitedWilderness = false
var talkToKid = false


var leaveVillageQuest = false



#Dialogue related stuff
var QMain = false
var QWild = false
var madeProfit = false
var NPCgiveNoMore = false #Give items once and not dup
#Quest is finished
var questComplete = {"Main": false, "Wild": false}
var Discount = ""

#TODO Add more if needed to stack of the items needed for NPC
var itemDialogue = [
	{
		"Name": "Twigs",
		"Value": 0
	},
	{
		"Name": "Rocks",
		"Value": 0
	},
	{
		"Name": "WaterBottle",
		"Value": 0
	},
	{
		"Name": "TinCans",
		"Value": 0
	}
]

var QVillager = ""

var villagersIndex = {
	"Accept": 0,
	"Anger": 1,
	"Bargin": 2,
	"Croak": 3,
	"Denial": 4,
	"Depress": 5,
	"OldMan": 6,
	
	"Rano": 7,
	"Ribbit": 8,
	"Hop": 9,
	"Leap": 10,
}

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
	#Sand
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -810,
		"posY": -626,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -749,
		"posY": -566,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -661,
		"posY": -577,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -539,
		"posY": -582,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -428,
		"posY": -550,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -336,
		"posY": -574,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -324,
		"posY": -126,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -381,
		"posY": -71,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -480,
		"posY": -89,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -519,
		"posY": 20,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -519,
		"posY": 106,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -832,
		"posY": 555,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -923,
		"posY": 601,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -981,
		"posY": 648,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -1000,
		"posY": 710,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -868,
		"posY": 786,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -431,
		"posY": 1139,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -378,
		"posY": 1197,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -374,
		"posY": 1260,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": -436,
		"posY": 1304,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": 1124,
		"posY": 1321,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": 1253,
		"posY": 1336,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": 1394,
		"posY": 1284,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": 1427,
		"posY": 1235,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/sand.tscn"),
		"posX": 1514,
		"posY": 1180,
		"Taken": false
	},
	
	
	
	
	
	
	
	
	
	#Tin Cans
	{
		"Item": preload("res://World Scene/Items/TinCan.tscn"),
		"posX": 303,
		"posY": -528,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/TinCan.tscn"),
		"posX": 747,
		"posY": -470,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/TinCan.tscn"),
		"posX": 639,
		"posY": -425,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/TinCan.tscn"),
		"posX": 219,
		"posY": -335,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/TinCan.tscn"),
		"posX": -543,
		"posY": 759,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/TinCan.tscn"),
		"posX": -733,
		"posY": 839,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/TinCan.tscn"),
		"posX": -499,
		"posY": 985,
		"Taken": false
	},
	
	
	
	
	
	
	
	
	
	#Water Bottles
	{
		"Item": preload("res://World Scene/Items/WaterBottle.tscn"),
		"posX": 414,
		"posY": -528,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/WaterBottle.tscn"),
		"posX": 303,
		"posY": -385,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/WaterBottle.tscn"),
		"posX": 47,
		"posY": -263,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/WaterBottle.tscn"),
		"posX": -73,
		"posY": -206,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/WaterBottle.tscn"),
		"posX": -199,
		"posY": -182,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/WaterBottle.tscn"),
		"posX": 1874,
		"posY": -159,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/WaterBottle.tscn"),
		"posX": 1876,
		"posY": 43,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/WaterBottle.tscn"),
		"posX": 2661,
		"posY": -527,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/WaterBottle.tscn"),
		"posX": 2552,
		"posY": 564,
		"Taken": false
	},
	
	
	
	
	
	
	
	
	
	#Moss
	{
		"Item": preload("res://World Scene/Items/Moss.tscn"),
		"posX": 1009,
		"posY": -461,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/Moss.tscn"),
		"posX": 399,
		"posY": -227,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/Moss.tscn"),
		"posX": -306,
		"posY": 303,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/Moss.tscn"),
		"posX": -309,
		"posY": 500,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/Moss.tscn"),
		"posX": -164,
		"posY": 1090,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/Moss.tscn"),
		"posX": -167,
		"posY": 1219,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/Moss.tscn"),
		"posX": 1738,
		"posY": 471,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/Moss.tscn"),
		"posX": 1653,
		"posY": 873,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/Moss.tscn"),
		"posX": 1553,
		"posY": 982,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/Moss.tscn"),
		"posX": 1088,
		"posY": 1240,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/Moss.tscn"),
		"posX": -148,
		"posY": -588,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/Moss.tscn"),
		"posX": 686,
		"posY": -662,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/Moss.tscn"),
		"posX": 1115,
		"posY": -641,
		"Taken": false
	},
	
	
	
	
	
	
	
	
	
	#Rocks
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 1908,
		"posY": -327,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 1638,
		"posY": -227,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 2330,
		"posY": 14,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 2123,
		"posY": 60,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 2219,
		"posY": 156,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 2232,
		"posY": 328,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 2450,
		"posY": 397,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 2089,
		"posY": 451,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 2301,
		"posY": 598,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 2398,
		"posY": 687,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 2463,
		"posY": 780,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 1925,
		"posY": 644,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 1996,
		"posY": 759,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/rock.tscn"),
		"posX": 1763,
		"posY": 743,
		"Taken": false
	},
	
	
	
	
	
	
	
	
	
	#Twigs
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 601,
		"posY": -180,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 879,
		"posY": -193,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 1039,
		"posY": -218,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 1281,
		"posY": -171,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 715,
		"posY": -63,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 268,
		"posY": -73,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 258,
		"posY": 92,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 323,
		"posY": 130,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": -144,
		"posY": 153,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": -212,
		"posY": 274,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": -126,
		"posY": 443,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 103,
		"posY": 601,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 258,
		"posY": 727,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 24,
		"posY": 879,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 166,
		"posY": 900,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 358,
		"posY": 965,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 1023,
		"posY": 1035,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 1599,
		"posY": 382,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 1601,
		"posY": 205,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 1490,
		"posY": 54,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 375,
		"posY": 1412,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 567,
		"posY": 1413,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 618,
		"posY": 1535,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 323,
		"posY": 1592,
		"Taken": false
	},
	{
		"Item": preload("res://World Scene/Items/twig.tscn"),
		"posX": 450,
		"posY": 1610,
		"Taken": false
	},
]
