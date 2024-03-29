extends Node


var day:int = 1

var twigItem = 0

var username = ""

var inventory:Array

var inventory_amount:Dictionary

#What is required to go to the next day
var inventory_requirement:Dictionary

var charLock = false



var visitTutorial = false
var visitedWilderness = false

#Spawn the item once in the wilderness. Prevents duplication
var itemSpawnOnce = false
