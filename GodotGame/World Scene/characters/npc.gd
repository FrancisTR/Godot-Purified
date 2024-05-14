extends Area2D
signal leave_village

@onready var dialogue_box = $FixedDialoguePosition/DialogueBox

#For Barry
@onready var BarryDestination = $NPCActions/BarryDestination/Marker2D.global_position
#For player on Day 7
@onready var PlayerDestination = $"../../Other/CharacterBody2D/Marker2D".global_position

var moving_speed = 200
var moving = false


var enterBody = false

var NPCname = null
var PressForDialogue_was_opened = false
var playerRuns = false

var exclamation = load("res://Assets/Custom/UI_Exclamation_Mark_Plate.png")
var question = load("res://Assets/Custom/UI_Question_Mark_Plate.png")

#For the old man on day 7
#This is a temp lock
var oldManTempLock = false



#Access the voices. Can activate Start, End, and Name
#TODO adds voices
var dialogue_voices = [
	
	
	# Days 1 #CONFIRMED
	{	
		# Tutorial 2
		#CONFIRMED
		"Talia": [
			{"Name": "Talia", "Start": "0:59", "End": "1:01", "Emotion": ""},
			{"Name": "Talia", "Start": "1:02.5", "End": "1:04.2", "Emotion": ""},
			{"Name": "Talia", "Start": "1:05.7", "End": "1:09.2", "Emotion": ""},
			
			#End Idx of getting me that rock again if player has no rock
			{"Name": "Talia", "Start": "1:11.1", "End": "1:13", "Emotion": ""},
		
			#End of training
			{"Name": "Talia", "Start": "1:14.4", "End": "1:19", "Emotion": ""},
		],
		
		
		#All Characters
		#CONFIRMED
		"Denial": [
			{"Name": "Main", "Start": "0:0.26", "End": "0:12.80", "Emotion": "Happy"},
			{"Name": "Denial", "Start": "0", "End": "0:9.5", "Emotion": "Anger"},
			{"Name": "Main", "Start": "0:14.03", "End": "0:20.86", "Emotion": ""},
		],
		
		#CONFIRMED
		"Anger": [
			{"Name": "Main", "Start": "0:0.26", "End": "0:12.80", "Emotion": "Happy"},
			{"Name": "Anger", "Start": "0:0", "End": "0:13", "Emotion": "Anger"},
			{"Name": "Main", "Start": "0:22.06", "End": "0:34.26", "Emotion": ""},
			{"Name": "Anger", "Start": "0:15", "End": "0:22", "Emotion": "Anger"},
			{"Name": "Main", "Start": "0:34.10", "End": "0:41.05", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"Bargin": [
			{"Name": "Main", "Start": "0:0.26", "End": "0:12.80", "Emotion": "Happy"},
			
			{"Name": "Bargin", "Start": "0:05.08", "End": "0:07.16", "Emotion": ""},
			{"Name": "Main", "Start": "0:42.20", "End": "0:45.00", "Emotion": ""},
			
			{"Name": "Bargin", "Start": "0:08.07", "End": "0:09.56", "Emotion": ""},
			{"Name": "Main", "Start": "0:42.20", "End": "0:45.00", "Emotion": ""},
			
			{"Name": "Bargin", "Start": "0:10.20", "End": "0:12.04", "Emotion": ""},
			{"Name": "Main", "Start": "0:42.20", "End": "0:45.00", "Emotion": ""},
			
			{"Name": "Bargin", "Start": "0:12.27", "End": "0:14.06", "Emotion": ""},
			{"Name": "Main", "Start": "0:42.20", "End": "0:45.00", "Emotion": ""},
			
			{"Name": "Bargin", "Start": "0:15.05", "End": "0:16.23", "Emotion": ""},
			{"Name": "Main", "Start": "0:46.15", "End": "0:48.20", "Emotion": ""},
			
			{"Name": "Bargin", "Start": "0:17.03", "End": "0:18.23", "Emotion": ""},
		],
		
		#CONFIRMED
		"Depress": [
			{"Name": "Main", "Start": "0:0.26", "End": "0:12.80", "Emotion": "Happy"},
			{"Name": "Depress", "Start": "0:04.20", "End": "0:04.90", "Emotion": ""},
			{"Name": "Main", "Start": "0:48.23", "End": "1:06.01", "Emotion": "Happy"},
			{"Name": "Depress", "Start": "0:04.90", "End": "0:06", "Emotion": ""},
			{"Name": "Main", "Start": "1:06.17", "End": "1:11.04", "Emotion": ""},
		],
		
		#CONFIRMED
		"Accept": [
			{"Name": "Main", "Start": "0:0.26", "End": "0:12.80", "Emotion": "Happy"},
			{"Name": "Accept", "Start": "0:00", "End": "0:01", "Emotion": "Happy"},
			
			{"Name": "Main", "Start": "1:17.05", "End": "1:20.59", "Emotion": "Happy"},
			{"Name": "Main", "Start": "1:11.06", "End": "1:16.02", "Emotion": "Happy"}, #Great!...
			

			{"Name": "Accept", "Start": "1:14.8", "End": "1:20.90", "Emotion": ""},
			{"Name": "Main", "Start": "1:21.00", "End": "1:26.22", "Emotion": ""},
			
			{"Name": "Accept", "Start": "1:21", "End": "1:22", "Emotion": "Happy"}, #Thanks
		],
		
		#CONFIRMED
		"Croak": [
			{"Name": "Main", "Start": "0:0.26", "End": "0:12.80", "Emotion": "Happy"},
			{"Name": "Croak", "Start": "0:00", "End": "0:02.5", "Emotion": ""},
			#If talked to barry, proceed
			{"Name": "Main", "Start": "1:37.18", "End": "1:41.05", "Emotion": "Happy"},
			{"Name": "Croak", "Start": "0:04", "End": "0:06.3", "Emotion": "Happy"},
			{"Name": "Main", "Start": "1:42.04", "End": "1:49.06", "Emotion": "Happy"},
			{"Name": "Croak", "Start": "0:08.7", "End": "0:15.5", "Emotion": "Sad"},
			{"Name": "Main", "Start": "1:50.03", "End": "1:57.00", "Emotion": ""},
			{"Name": "Croak", "Start": "0:17.5", "End": "0:17.9", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"OldMan": [
			{"Name": "Main", "Start": "0:0.26", "End": "0:12.80", "Emotion": "Happy"},
			{"Name": "OldMan", "Start": "0:5.8", "End": "0:20", "Emotion": "Angry"},
			{"Name": "Main", "Start": "02:00.07", "End": "2:02.12", "Emotion": ""},
			{"Name": "OldMan", "Start": "0", "End": "0", "Emotion": "Angry"},
			{"Name": "Main", "Start": "02:03.09", "End": "02:09", "Emotion": "Happy"},
		]
	},
	
	
	
	
	
	
	
	
	
	
	# Days 2 #CONFIRMED
	{	
		#All Characters
		
		#CONFIRMED
		"Denial": [
			{"Name": "Main", "Start": "02:09.07", "End": "02:15.89", "Emotion": ""},
			{"Name": "Main", "Start": "2:16.06", "End": "2:27.12", "Emotion": "Happy"},
			{"Name": "Main", "Start": "2:27.14", "End": "2:35.05", "Emotion": "Happy"},
			{"Name": "Main", "Start": "2:35.08", "End": "2:36.09", "Emotion": "Happy"},
			
			{"Name": "Denial", "Start": "0:9.6", "End": "0:16.3", "Emotion": ""},
			{"Name": "Main", "Start": "02:37.06", "End": "02:38.17", "Emotion": ""},
			{"Name": "Denial", "Start": "0:16.4", "End": "0:17.7", "Emotion": "Happy"},
			{"Name": "Main", "Start": "1:11.06", "End": "1:16.02", "Emotion": "Happy"},
			{"Name": "Main", "Start": "1:17.05", "End": "1:20.89", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"Anger": [
			{"Name": "Main", "Start": "02:38.28", "End": "02:47.09", "Emotion": ""},
			{"Name": "Anger", "Start": "0:31", "End": "0:44", "Emotion": "Anger"},
			{"Name": "Main", "Start": "02:47.25", "End": "02:50.78", "Emotion": "Surprised"},
			{"Name": "Anger", "Start": "0:46", "End": "0:51.2", "Emotion": ""},
			{"Name": "Main", "Start": "02:51.13", "End": "02:54.73", "Emotion": "Sad"},
		],
		
		#CONFIRMED
		"Bargin": [
			{"Name": "Main", "Start": "02:55.13", "End": "03:05.95", "Emotion": "Happy"},
			
			{"Name": "Bargin", "Start": "0:05.08", "End": "0:07.18", "Emotion": ""},
			{"Name": "Main", "Start": "0:42.20", "End": "0:45.00", "Emotion": ""},
			
			{"Name": "Bargin", "Start": "0:08.07", "End": "0:09.96", "Emotion": ""},
			{"Name": "Main", "Start": "0:42.20", "End": "0:45.00", "Emotion": ""},
			
			{"Name": "Bargin", "Start": "0:10.20", "End": "0:12.04", "Emotion": ""},
			{"Name": "Main", "Start": "0:42.20", "End": "0:45.00", "Emotion": ""},
			
			{"Name": "Bargin", "Start": "0:12.27", "End": "0:14.06", "Emotion": ""},
			{"Name": "Main", "Start": "0:42.20", "End": "0:45.00", "Emotion": ""},
			
			{"Name": "Bargin", "Start": "0:20.12", "End": "0:22.06", "Emotion": ""},
			{"Name": "Main", "Start": "03:07.29", "End": "03:09.86", "Emotion": ""},
			{"Name": "Bargin", "Start": "0:22.47", "End": "0:24.08", "Emotion": ""},
			
			{"Name": "Main", "Start": "1:11.06", "End": "1:16.02", "Emotion": "Happy"},
			
			{"Name": "Bargin", "Start": "1:55.09", "End": "2:01.16", "Emotion": ""},
			
			{"Name": "Main", "Start": "13:27.03", "End": "13:30.20", "Emotion": ""},
			
			{"Name": "Bargin", "Start": "2:02.05", "End": "2:04.02", "Emotion": ""}, #Thanks
		],
		
		#CONFIRMED
		"Depress": [
			{"Name": "Main", "Start": "03:10.05", "End": "03:18.12", "Emotion": "Happy"},
			{"Name": "Depress", "Start": "0:04.20", "End": "0:04.90", "Emotion": ""},
			{"Name": "Main", "Start": "03:19.10", "End": "03:21.06", "Emotion": "Sad"},
			{"Name": "Depress", "Start": "0:04.90", "End": "0:06", "Emotion": ""},
			{"Name": "Main", "Start": "03:21.29", "End": "03:24.01", "Emotion": ""},
			{"Name": "Depress", "Start": "0:06.05", "End": "0:07.25", "Emotion": ""},
			{"Name": "Main", "Start": "03:25.00", "End": "03:28.07", "Emotion": ""},
		],
		
		#CONFIRMED
		"Accept": [
			{"Name": "Main", "Start": "14:18.06", "End": "14:24.93", "Emotion": "Happy"},
			{"Name": "Accept", "Start": "0:07.8", "End": "0:09", "Emotion": "Happy"},
			{"Name": "Main", "Start": "4:05.29", "End": "04:11.20", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"Croak": [
			{"Name": "Main", "Start": "03:42.13", "End": "03:45.05", "Emotion": "Happy"},
			{"Name": "Croak", "Start": "0:19.5", "End": "0:24.8", "Emotion": "Sad"},
			{"Name": "Main", "Start": "03:45.07", "End": "03:52.11", "Emotion": ""},
			{"Name": "Main", "Start": "03:53.02", "End": "03:56.08", "Emotion": "Happy"},
			{"Name": "Croak", "Start": "0:24.8", "End": "0:25.6", "Emotion": "Happy"},
			{"Name": "Main", "Start": "03:56.21", "End": "03:59.08", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"OldMan": [
			{"Name": "Main", "Start": "04:46.01", "End": "04:48.82", "Emotion": ""},
			{"Name": "OldMan", "Start": "0:21.3", "End": "0:25.5", "Emotion": ""},
			{"Name": "Main", "Start": "04:49.09", "End": "04:53.01", "Emotion": "Happy"},
			{"Name": "OldMan", "Start": "0", "End": "0", "Emotion": "Angry"},
			{"Name": "Main", "Start": "04:53.19", "End": "04:56.94", "Emotion": ""},
		]
	},
	
	
	
	
	
	
	
	
	
	
	# Days 3 #CONFIRMED
	{	
		#All Characters
		
		#CONFIRMED
		"Denial": [
			{"Name": "Main", "Start": "03:59.13", "End": "04:04.99", "Emotion": ""},
			{"Name": "Denial", "Start": "0:17.8", "End": "0:21.5", "Emotion": "Happy"},
			{"Name": "Main", "Start": "4:05.29", "End": "04:11.25", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"Anger": [
			{"Name": "Anger", "Start": "0", "End": "0", "Emotion": ""},
		],
		
		#CONFIRMED
		"Bargin": [
			{"Name": "Main", "Start": "04:16.06", "End": "04:18.00", "Emotion": "Happy"},
			{"Name": "Bargin", "Start": "0:25.01", "End": "0:27.25", "Emotion": "Sad"},
			{"Name": "Main", "Start": "04:18.22", "End": "04:19.27", "Emotion": "Surprised"},
		],
		
		#CONFIRMED
		"Depress": [
			{"Name": "Depress", "Start": "0", "End": "0", "Emotion": ""},
		],
		
		#CONFIRMED
		"Accept": [
			{"Name": "Main", "Start": "14:18.06", "End": "14:24.95", "Emotion": "Happy"},
			{"Name": "Accept", "Start": "0:07.8", "End": "0:09", "Emotion": "Happy"},
			{"Name": "Main", "Start": "4:05.29", "End": "04:11.25", "Emotion": "Happy"},
			{"Name": "Accept", "Start": "1:22.5", "End": "1:29", "Emotion": "Happy"},
			{"Name": "Main", "Start": "13:31.06", "End": "13:35.18", "Emotion": "Happy"},
			
			{"Name": "Accept", "Start": "1:29", "End": "1:30.5", "Emotion": "Happy"}, #Thanks
		],
		
		#CONFIRMED
		"OldMan": [
			{"Name": "Main", "Start": "04:46.01", "End": "04:48.92", "Emotion": ""},
			{"Name": "OldMan", "Start": "0:21.3", "End": "0:25.5", "Emotion": ""},
			{"Name": "Main", "Start": "04:49.09", "End": "04:53.01", "Emotion": "Happy"},
			{"Name": "OldMan", "Start": "0", "End": "0", "Emotion": "Sad"},
			{"Name": "Main", "Start": "04:53.19", "End": "04:56.99", "Emotion": ""},
		]
	},
	
	
	
	
	
	
	
	
	
	# Days 4 #CONFIRMED
	{	
		#All Characters
		
		#Discount
		
		#CONFIRMED
		"Denial": [
			#Two choices for main on 15% or 35%
			#Start: 05:21.09 (15%) 05:31.26 (35%)
			#End: 05:31.02 (15%) 05:41.29 (35%)
			{"Name": "Main", "Start": "05:21.09", "End": "05:31.02", "Emotion": "Fear"}, #15%
			{"Name": "Main", "Start": "05:31.26", "End": "05:41.99", "Emotion": "Fear"}, #35%
			
			{"Name": "Denial", "Start": "0:26.1", "End": "0:30.4", "Emotion": "Happy"},
			{"Name": "Main", "Start": "05:42.28", "End": "05:44.95", "Emotion": "Fear"},
		],
		
		#CONFIRMED
		"Anger": [
			#Start: 05:21.09 (15%) 05:31.26 (35%)
			#End: 05:31.02 (15%) 05:41.29 (35%)
			{"Name": "Main", "Start": "05:21.09", "End": "05:31.02", "Emotion": "Fear"},
			{"Name": "Main", "Start": "05:31.26", "End": "05:41.99", "Emotion": "Fear"},
			
			{"Name": "Anger", "Start": "3:12.16", "End": "3:19.08", "Emotion": ""},
			{"Name": "Main", "Start": "05:42.28", "End": "05:44.90", "Emotion": "Fear"},
		],
		
		
		#Start: 05:21.09 (15%) 05:31.26 (35%)
		#End: 05:31.02 (15%) 05:41.29 (35%)
		#CONFIRMED
		"Depress": [
			{"Name": "Main", "Start": "05:21.09", "End": "05:31.02", "Emotion": "Fear"},
			{"Name": "Main", "Start": "05:31.26", "End": "05:41.99", "Emotion": "Fear"},
			
			{"Name": "Depress", "Start": "0:04.20", "End": "0:04.90", "Emotion": ""},
			{"Name": "Main", "Start": "05:45", "End": "05:47.05", "Emotion": "Fear"},
		],
		
		#CONFIRMED
		"Accept": [
			#Start: 05:21.09 (15%) 05:31.26 (35%)
			#End: 05:31.02 (15%) 05:41.29 (35%)
			{"Name": "Main", "Start": "05:21.09", "End": "05:31.02", "Emotion": "Fear"},
			{"Name": "Main", "Start": "05:31.26", "End": "05:41.99", "Emotion": "Fear"},
			
			{"Name": "Accept", "Start": "0:09", "End": "0:11.8", "Emotion": "Suprised"},
			{"Name": "Main", "Start": "05:49.06", "End": "05:51.04", "Emotion": "Fear"},
		],
		
		#CONFIRMED
		"OldMan": [
			{"Name": "Main", "Start": "05:02.00", "End": "05:05.28", "Emotion": ""},
			{"Name": "OldMan", "Start": "0:27.5", "End": "0:35", "Emotion": "Sad"},
			{"Name": "Main", "Start": "05:06.20", "End": "05:07.34", "Emotion": "Surprised"},
			{"Name": "OldMan", "Start": "0:36", "End": "0:40.5", "Emotion": "Sad"},
			{"Name": "Main", "Start": "05:09.05", "End": "05:10.12", "Emotion": "Fear"},
			{"Name": "OldMan", "Start": "0:41.6", "End": "0:53.3", "Emotion": ""},
			{"Name": "Main", "Start": "05:12.00", "End": "05:12.44", "Emotion": "Sad"},
			
			{"Name": "Main", "Start": "05:14.11", "End": "05:21.04", "Emotion": "Sad"},
		],
		
		"Rano": [
			{"Name": "Rano", "Start": "2:22.1", "End": "2:27.5", "Emotion": "Sad"},
			{"Name": "Main", "Start": "14:07.00", "End": "14:11.87", "Emotion": ""},
			{"Name": "Rano", "Start": "2:28.4", "End": "2:36", "Emotion": "Sad"},
			{"Name": "Rano", "Start": "2:36.8", "End": "0:164.463562011719", "Emotion": "Sad"},
		],
		"Leap": [
			{"Name": "Leap", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Hop": [
			{"Name": "Hop", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Ribbit": [
			{"Name": "Ribbit", "Start": "0", "End": "0", "Emotion": ""},
		],
	},
	
	
	
	
	
	
	
	
	
	
	# Days 5 #CONFIRMED
	{	
		#All Characters
		#CONFIRMED
		"Denial": [
			# Start: 05:51.08 (25%) 06:06.02 (40%)
			# End: 06:04.29 (25%) 06:17.18 (40%)
			{"Name": "Main", "Start": "05:51.08", "End": "06:04.59", "Emotion": ""}, #25%
			{"Name": "Main", "Start": "06:06.02", "End": "06:17.18", "Emotion": ""}, #40%
			
			{"Name": "Denial", "Start": "0:31.14", "End": "0:33.58", "Emotion": ""},
			{"Name": "Main", "Start": "06:18.20", "End": "06:20.02", "Emotion": ""},
			{"Name": "Denial", "Start": "0:35.05", "End": "0:45.13", "Emotion": ""},
			{"Name": "Main", "Start": "06:21.01", "End": "06:23.15", "Emotion": ""},
		],
		
		#CONFIRMED
		"Anger": [
			#Start: 05:51.08 (25%) 06:06.02 (40%)
			#End: 06:04.29 (25%) 06:17.18 (40%)
			{"Name": "Main", "Start": "05:51.08", "End": "06:04.59", "Emotion": ""},
			{"Name": "Main", "Start": "06:06.02", "End": "06:17.18", "Emotion": ""},
			
			
			{"Name": "Anger", "Start": "0:57.22", "End": "1:05.27", "Emotion": "Happy"},
			{"Name": "Anger", "Start": "1:06.04", "End": "1:14.08", "Emotion": "Anger"},
			{"Name": "Anger", "Start": "1:14.23", "End": "1:27.05", "Emotion": ""},
			
			{"Name": "Main", "Start": "06:24.16", "End": "06:25.22", "Emotion": "Surprised"},
			{"Name": "Anger", "Start": "1:28", "End": "1:38.5", "Emotion": "Anger"},
		],
		
		#CONFIRMED
		"Bargin": [
			{"Name": "Main", "Start": "06:27.16", "End": "06:30.17", "Emotion": ""},
			
			{"Name": "Bargin", "Start": "0:29.06", "End": "0:31.16", "Emotion": "Fear"},
			
			{"Name": "Main", "Start": "06:30.25", "End": "06:33.11", "Emotion": "Sad"},
			
			{"Name": "Bargin", "Start": "0:32.07", "End": "0:37.03", "Emotion": "Fear"},
			
			{"Name": "Main", "Start": "06:34.07", "End": "06:37.15", "Emotion": ""},
			
			{"Name": "Bargin", "Start": "0:38.03", "End": "0:45.07", "Emotion": "Fear"},
			
			{"Name": "Main", "Start": "06:38.10", "End": "06:40.88", "Emotion": "Sad"},
			
			{"Name": "Bargin", "Start": "0:45.17", "End": "0:47.03", "Emotion": "Fear"},
			
			{"Name": "Main", "Start": "0", "End": "0", "Emotion": "Sad"},
		],
		
		#CONFIRMED
		"Depress": [
			#Start: 05:51.08 (25%) 06:06.02 (40%)
			#End: 06:04.29 (25%) 06:17.18 (40%)
			{"Name": "Main", "Start": "05:51.08 ", "End": "06:04.59", "Emotion": ""},
			{"Name": "Main", "Start": "06:06.02", "End": "06:17.18", "Emotion": ""},
			
			{"Name": "Depress", "Start": "0:04.20", "End": "0:04.90", "Emotion": ""},
			{"Name": "Main", "Start": "06:44.01", "End": "06:47.56", "Emotion": ""},
			{"Name": "Depress", "Start": "0:00.08", "End": "0:01.10", "Emotion": ""},
			{"Name": "Main", "Start": "06:48.22", "End": "06:52.53", "Emotion": ""},
			{"Name": "Depress", "Start": "0:07.74", "End": "0:08.13", "Emotion": ""},
		],
		
		#CONFIRMED
		"Accept": [
			#Start: 05:51.08 (25%) 06:06.02 (40%)
			#End: 06:04.29 (25%) 06:17.18 (40%)
			{"Name": "Main", "Start": "05:51.08", "End": "06:04.59", "Emotion": ""},
			{"Name": "Main", "Start": "06:06.02", "End": "06:17.18", "Emotion": ""},
			
			
			{"Name": "Accept", "Start": "0:11.95", "End": "0:14.02", "Emotion": ""},
			{"Name": "Accept", "Start": "0:14.42", "End": "0:19.35", "Emotion": ""},
			{"Name": "Accept", "Start": "0:19.35", "End": "0:26.87", "Emotion": "Sad"},
			{"Name": "Accept", "Start": "0:26.97", "End": "0:31.02", "Emotion": ""},
			
			{"Name": "Main", "Start": "06:54.12", "End": "06:57.10", "Emotion": "Happy"},
			{"Name": "Accept", "Start": "0:07.8", "End": "0:09", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"OldMan": [
			{"Name": "Main", "Start": "06:57.20", "End": "06:58.05", "Emotion": "Fear"},
			{"Name": "OldMan", "Start": "0:54.5", "End": "1:00", "Emotion": "Anger"},
			{"Name": "Main", "Start": "06:59.17", "End": "07:01.56", "Emotion": ""},
			{"Name": "OldMan", "Start": "1:01.3", "End": "1:09.3", "Emotion": ""},
			{"Name": "Main", "Start": "07:04.02", "End": "07:06.12", "Emotion": ""},
			{"Name": "OldMan", "Start": "1:10.3", "End": "1:14.3", "Emotion": ""},
		],
		
		"Rano": [
			{"Name": "Rano", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Leap": [
			{"Name": "Leap", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Hop": [
			{"Name": "Hop", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Ribbit": [
			{"Name": "Ribbit", "Start": "0", "End": "0", "Emotion": ""},
		],
	},
	
	
	
	
	
	
	
	
	
	# Days 6
	{	
		#All Characters
		#CONFIRMED
		"Denial": [
			{"Name": "Main", "Start": "07:08.00", "End": "07:16.12", "Emotion": "Happy"},
			
			{"Name": "Denial", "Start": "0:46.26", "End": "0:54.14", "Emotion": ""},
			{"Name": "Denial", "Start": "0:54.15", "End": "1:07.11", "Emotion": "Happy"},
			{"Name": "Denial", "Start": "1:07.16", "End": "1:10.03", "Emotion": ""},
			
			{"Name": "Main", "Start": "07:17.05", "End": "07:19.02", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"Anger": [
			{"Name": "Main", "Start": "07:08.00", "End": "07:16.12", "Emotion": "Happy"},
			
			{"Name": "Anger", "Start": "1:38.93", "End": "1:49", "Emotion": ""},
			{"Name": "Anger", "Start": "1:49.06", "End": "1:57.03", "Emotion": ""},
			{"Name": "Anger", "Start": "1:57.10", "End": "2:01.01", "Emotion": ""},
			
			{"Name": "Main", "Start": "07:17.05", "End": "07:19.02", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"Bargin": [
			{"Name": "Main", "Start": "07:08.00", "End": "07:16.12", "Emotion": "Happy"},
			{"Name": "Bargin", "Start": "0:48.15", "End": "0:56.18", "Emotion": ""},
			{"Name": "Main", "Start": "07:22.08", "End": "07:24.09", "Emotion": ""},
			{"Name": "Bargin", "Start": "0:57.04", "End": "1:05.54", "Emotion": "Happy"},
			{"Name": "Main", "Start": "07:25.12", "End": "07:27.02", "Emotion": ""},
		],
		
		#CONFIRMED
		"Depress": [
			{"Name": "Main", "Start": "07:08.00", "End": "07:16.12", "Emotion": "Happy"},
			{"Name": "Depress", "Start": "0:01.05", "End": "0:02.02", "Emotion": "Happy"},
			{"Name": "Main", "Start": "07:29.25", "End": "07:31.15", "Emotion": ""},
			{"Name": "Depress", "Start": "0:13.55", "End": "0:16.02", "Emotion": ""},
			{"Name": "Main", "Start": "07:32.00", "End": "07:34.09", "Emotion": "Sad"},
			{"Name": "Depress", "Start": "0:04.20", "End": "0:04.90", "Emotion": ""},
			{"Name": "Main", "Start": "07:17.05", "End": "07:19.02", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"Accept": [
			{"Name": "Main", "Start": "07:08.00", "End": "07:16.12", "Emotion": "Happy"},
			
			
			{"Name": "Accept", "Start": "0:31.02", "End": "0:37.07", "Emotion": ""},
			{"Name": "Accept", "Start": "0:37.07", "End": "0:42.69", "Emotion": ""},
			{"Name": "Accept", "Start": "0:43.01", "End": "0:45", "Emotion": "Happy"},
			
			{"Name": "Main", "Start": "07:17.05", "End": "07:19.02", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"OldMan": [
			{"Name": "Main", "Start": "07:37.19", "End": "07:40.14", "Emotion": "Sad"},
			{"Name": "OldMan", "Start": "1:16.8", "End": "1:21", "Emotion": ""},
		],
		
		"Rano": [
			{"Name": "Rano", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Leap": [
			{"Name": "Leap", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Hop": [
			{"Name": "Hop", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Ribbit": [
			{"Name": "Ribbit", "Start": "0", "End": "0", "Emotion": ""},
		],
	},
	
	
	
	
	
	
	# Days 7 #CONFIRMED
	{	
		#All Characters
		"Denial": [
			{"Name": "Denial", "Start": "0", "End": "0", "Emotion": ""},
		],
		
		"Anger": [
			{"Name": "Anger", "Start": "0", "End": "0", "Emotion": ""},
		],
		
		"Bargin": [
			{"Name": "Bargin", "Start": "0", "End": "0", "Emotion": ""},
		],
		
		"Depress": [
			{"Name": "Depress", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Accept": [
			{"Name": "Accept", "Start": "0", "End": "0", "Emotion": ""},
		],
		
		#TODO Lots of branches
		#CONFIRMED
		"OldMan": [
			#First Flow
			{"Name": "Main", "Start": "08:11.08", "End": "08:15.01", "Emotion": "Sad"},
			{"Name": "OldMan", "Start": "1:21.9", "End": "1:27", "Emotion": ""},
			{"Name": "Main", "Start": "08:15.19", "End": "08:17.10", "Emotion": "Sad"},
			{"Name": "OldMan", "Start": "1:28", "End": "1:30", "Emotion": ""},
			{"Name": "Main", "Start": "08:17.27", "End": "08:32.03", "Emotion": "Sad"},
			{"Name": "OldMan", "Start": "2:23.2", "End": "2:32", "Emotion": ""},
			
			#Second Flow
			#WaterBottleSpecial
			{"Name": "OldMan", "Start": "2:32.3", "End": "2:41.5", "Emotion": ""},
			#Pot
			{"Name": "OldMan", "Start": "2:42.2", "End": "2:51.5", "Emotion": ""},
			#Filter
			{"Name": "OldMan", "Start": "2:51.6", "End": "3:05", "Emotion": ""},
			
			#Third Flow (If all items have been shown)
			{"Name": "OldMan", "Start": "3:07.7", "End": "3:09", "Emotion": ""},
			{"Name": "Main", "Start": "13:51.10", "End": "13:53.02", "Emotion": ""},
			{"Name": "OldMan", "Start": "3:11.1", "End": "3:18", "Emotion": ""},
			
			
			#Last Flow
			{"Name": "OldMan", "Start": "3:18.3", "End": "3:27", "Emotion": ""},
			{"Name": "Main", "Start": "13:54.10", "End": "13:56.02", "Emotion": ""},
			{"Name": "OldMan", "Start": "3:27.7", "End": "0:211.938278198242", "Emotion": ""},
			{"Name": "OldMan", "Start": "1:31.5", "End": "1:46.5", "Emotion": ""},
			{"Name": "Main", "Start": "08:33.27", "End": "08:36.53", "Emotion": ""},
			
			
			#Try again(Last Idx)
			{"Name": "OldMan", "Start": "3:05.4", "End": "3:07", "Emotion": ""},
		],
		
		
		"Rano": [
			{"Name": "Rano", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Leap": [
			{"Name": "Leap", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Hop": [
			{"Name": "Hop", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Ribbit": [
			{"Name": "Ribbit", "Start": "0", "End": "0", "Emotion": ""},
		],
	},
	
	
	
	
	
	
	
	
	
	# Days 8 #CONFIRMED
	{	
		#All Characters
		#CONFIRMED
		"Denial": [
			{"Name": "Main", "Start": "08:39.28", "End": "08:52.07", "Emotion": "Sad"},
			
			{"Name": "Denial", "Start": "2:01.14", "End": "2:07.07", "Emotion": ""},
			
			{"Name": "Main", "Start": "14:01.10", "End": "14:04.26", "Emotion": "Happy"},
			{"Name": "Denial", "Start": "2:07.29", "End": "2:10.08", "Emotion": "Happy"}, #Thanks
		],
		
		#CONFIRMED
		"Anger": [
			{"Name": "Main", "Start": "08:39.28", "End": "08:52.07", "Emotion": "Sad"},
			{"Name": "Anger", "Start": "2:02", "End": "2:12", "Emotion": "Happy"},
			{"Name": "Main", "Start": "08:58.06", "End": "08:59.43", "Emotion": "Happy"},
			{"Name": "Anger", "Start": "2:12.5", "End": "2:15", "Emotion": "Happy"},
			
			{"Name": "Anger", "Start": "2:17", "End": "2:18", "Emotion": ""}, #Thanks
		],
		
		#CONFIRMED
		"Bargin": [
			{"Name": "Main", "Start": "08:39.28", "End": "08:52.07", "Emotion": "Sad"},
			{"Name": "Bargin", "Start": "2:04.02", "End": "2:15", "Emotion": "Sad"},
			{"Name": "Main", "Start": "09:01.09", "End": "09:04.09", "Emotion": ""},
			
			{"Name": "Bargin", "Start": "1:41.03", "End": "1:44.02", "Emotion": ""},
			{"Name": "Bargin", "Start": "1:44.18", "End": "1:46.18", "Emotion": ""}, #Thanks
		],
		
		#CONFIRMED
		"Depress": [
			{"Name": "Main", "Start": "08:39.28", "End": "08:52.07", "Emotion": "Sad"},
			{"Name": "Depress", "Start": "0:04.20", "End": "0:04.90", "Emotion": ""},
			{"Name": "Main", "Start": "09:06.06", "End": "09:08.25", "Emotion": "Surprised"},
			{"Name": "Depress", "Start": "0:02.00", "End": "0:03.14", "Emotion": ""},
			{"Name": "Main", "Start": "09:09.12", "End": "09:12.14", "Emotion": ""},
			{"Name": "Depress", "Start": "0:03.03", "End": "0:04.01", "Emotion": ""},
			{"Name": "Main", "Start": "09:13.23", "End": "09:16.05", "Emotion": ""},
			{"Name": "Depress", "Start": "0", "End": "0", "Emotion": ""},
			{"Name": "Main", "Start": "09:16.22", "End": "09:18.51", "Emotion": ""},
		],
		
		#CONFIRMED
		"Accept": [
			{"Name": "Main", "Start": "08:39.28", "End": "08:52.07", "Emotion": "Sad"},
			{"Name": "Accept", "Start": "0:45", "End": "0:46.6", "Emotion": "Sad"},
			{"Name": "Main", "Start": "09:19.23", "End": "09:21.17", "Emotion": ""},
			{"Name": "Accept", "Start": "0:46.6", "End": "0:52", "Emotion": "Happy"},
			{"Name": "Main", "Start": "08:58.06", "End": "08:59.43", "Emotion": "Happy"},
			
			{"Name": "Accept", "Start": "1:30.8", "End": "0:94.0271224975586", "Emotion": "Happy"}, #Thanks TODO: Broken
		],
		
		#CONFIRMED
		"OldMan": [
			{"Name": "Main", "Start": "09:25.25", "End": "09:35.03", "Emotion": ""},
			{"Name": "OldMan", "Start": "1:47.6", "End": "1:51.5", "Emotion": "Happy"},
			{"Name": "Main", "Start": "09:35.23", "End": "09:39.11", "Emotion": ""},
		],
		
		"Rano": [
			{"Name": "Rano", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Leap": [
			{"Name": "Leap", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Hop": [
			{"Name": "Hop", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Ribbit": [
			{"Name": "Ribbit", "Start": "0", "End": "0", "Emotion": ""},
		],
	},
	
	
	
	
	
	
	
	
	
	# Days 9 #CONFIRMED
	{	
		#All Characters
		#CONFIRMED
		"Denial": [
			{"Name": "Main", "Start": "09:45.24", "End": "09:47.10", "Emotion": "Happy"},
			{"Name": "Denial", "Start": "1:18.01", "End": "1:22.44", "Emotion": ""},
			{"Name": "Main", "Start": "09:48.01", "End": "09:57.24", "Emotion": "Happy"},
			{"Name": "Denial", "Start": "1:24.11", "End": "1:28.01", "Emotion": "Disgust"},
			{"Name": "Main", "Start": "09:58.15", "End": "10:01.45", "Emotion": "Surprised"},
			{"Name": "Denial", "Start": "1:29.07", "End": "1:34.02", "Emotion": "Happy"},
			{"Name": "Main", "Start": "10:02.27", "End": "10:07.10", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"Anger": [
			{"Name": "Main", "Start": "10:08.18", "End": "10:10.05", "Emotion": "Happy"},
			{"Name": "Anger", "Start": "2:19.5", "End": "2:30", "Emotion": "Fear"},
			
			{"Name": "Main", "Start": "10:10.20", "End": "10:23.24", "Emotion": "Disgust"},
			{"Name": "Main", "Start": "10:24.01", "End": "10:31.20", "Emotion": ""},
			{"Name": "Main", "Start": "10:31.24", "End": "10:36.18", "Emotion": "Happy"},
			
			{"Name": "Anger", "Start": "2:30", "End": "2:34", "Emotion": "Surprised"},
		],
		
		#CONFIRMED
		"Bargin": [
			{"Name": "Main", "Start": "10:38.07", "End": "10:41.03", "Emotion": "Happy"},
			{"Name": "Bargin", "Start": "1:46.23", "End": "1:55.09", "Emotion": ""},
			{"Name": "Main", "Start": "10:41.25", "End": "10:46.96", "Emotion": ""},
			{"Name": "Bargin", "Start": "1:27.17", "End": "1:29.20", "Emotion": "Sad"},
			{"Name": "Main", "Start": "10:47.24", "End": "10:49.12", "Emotion": ""},
			
			#Use the same audio "Thanks" on Day 8
			{"Name": "Bargin", "Start": "1:44.18", "End": "1:46.18", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"Depress": [
			{"Name": "Main", "Start": "10:50.09", "End": "10:55.12", "Emotion": "Happy"},
			{"Name": "Depress", "Start": "0:04.20", "End": "0:04.90", "Emotion": ""},
			{"Name": "Main", "Start": "10:56.08", "End": "11:01.10", "Emotion": ""},
			{"Name": "Depress", "Start": "0:09.03", "End": "0:09.95", "Emotion": ""},
			
			{"Name": "Main", "Start": "11:02.08", "End": "11:08.18", "Emotion": ""},
			{"Name": "Main", "Start": "11:08.21", "End": "11:13.26", "Emotion": ""},
			{"Name": "Main", "Start": "11:13.30", "End": "11:21.27", "Emotion": "Happy"},
			{"Name": "Main", "Start": "11:21.28", "End": "11:26.28", "Emotion": "Happy"},
			
			{"Name": "Depress", "Start": "0:09.80", "End": "0:10.75", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"Accept": [
			{"Name": "Main", "Start": "11:27.29", "End": "11:36.18", "Emotion": "Happy"},
			{"Name": "Accept", "Start": "0:52", "End": "1:00", "Emotion": ""},
			{"Name": "Main", "Start": "14:11.29", "End": "14:17.18", "Emotion": "Happy"},
			{"Name": "Accept", "Start": "1:00.5", "End": "1:01.5", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"OldMan": [
			{"Name": "Main", "Start": "11:40.14", "End": "11:44.24", "Emotion": "Happy"},
			{"Name": "OldMan", "Start": "1:51.8", "End": "1:58.5", "Emotion": ""},
			{"Name": "Main", "Start": "11:45.10", "End": "11:47.46", "Emotion": ""},
			{"Name": "OldMan", "Start": "1:59.6", "End": "2:02.8", "Emotion": "Happy"},
		],
		
		
		"Rano": [
			{"Name": "Rano", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Leap": [
			{"Name": "Leap", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Hop": [
			{"Name": "Hop", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Ribbit": [
			{"Name": "Ribbit", "Start": "0", "End": "0", "Emotion": ""},
		],
	},
	
	
	
	
	
	
	
	
	
	# Days 10 #CONFIRMED
	{	
		#All Characters
		#CONFIRMED
		"Denial": [
			{"Name": "Main", "Start": "11:49.07", "End": "11:51.44", "Emotion": ""},
			{"Name": "Denial", "Start": "1:35.16", "End": "1:43.56", "Emotion": "Happy"},
			{"Name": "Main", "Start": "11:52.29", "End": "11:55.30", "Emotion": "Sad"},
			{"Name": "Denial", "Start": "1:44.25", "End": "1:45.51", "Emotion": ""},
			{"Name": "Main", "Start": "11:56.06", "End": "11:58.07", "Emotion": ""},
		],
		
		#CONFIRMED
		"Anger": [
			{"Name": "Main", "Start": "11:58.25", "End": "12:00.43", "Emotion": "Happy"},
			{"Name": "Anger", "Start": "3:04.4", "End": "3:10.5", "Emotion": ""},
			{"Name": "Main", "Start": "12:00.22", "End": "12:06.16", "Emotion": ""},
			
			
			{"Name": "Anger", "Start": "2:44.16", "End": "2:50.02", "Emotion": "Anger"},
			{"Name": "Anger", "Start": "2:50.12", "End": "3:01.23", "Emotion": ""},
			
			{"Name": "Main", "Start": "12:07.03", "End": "12:12.05", "Emotion": ""},
			
			{"Name": "Anger", "Start": "3:02", "End": "0:183.147399902344", "Emotion": "Happy"}, #Thanks
		],
		
		#CONFIRMED
		"Bargin": [
			{"Name": "Main", "Start": "12:12.20", "End": "12:15.24", "Emotion": "Sad"},
			{"Name": "Bargin", "Start": "1:30.18", "End": "1:32.03", "Emotion": "Fear"},
			{"Name": "Main", "Start": "12:16.24", "End": "12:26.26", "Emotion": "Sad"},
			{"Name": "Bargin", "Start": "1:33.01", "End": "1:38.07", "Emotion": "Surprised"},
			{"Name": "Main", "Start": "12:27.13", "End": "12:33.04", "Emotion": ""},
			{"Name": "Bargin", "Start": "1:38.27", "End": "1:39.45", "Emotion": "Fear"},
			{"Name": "Main", "Start": "12:34.23", "End": "12:48.18", "Emotion": ""},
		],
		
		#CONFIRMED
		"Depress": [
			{"Name": "Main", "Start": "12:49.14", "End": "12:54.07", "Emotion": "Happy"},
			{"Name": "Depress", "Start": "0:10.50", "End": "0:12.14", "Emotion": "Happy"},
			{"Name": "Main", "Start": "12:55.03", "End": "13:00.20", "Emotion": "Happy"},
			{"Name": "Depress", "Start": "0:07.64", "End": "0:08.13", "Emotion": "Happy"},
		],
		
		#CONFIRMED
		"Accept": [
			{"Name": "Main", "Start": "13:01.09", "End": "13:02.18", "Emotion": "Happy"},
			{"Name": "Accept", "Start": "1:01.5", "End": "1:04.5", "Emotion": "Happy"},
			{"Name": "Main", "Start": "13:02.28", "End": "13:04.12", "Emotion": "Happy"},
			{"Name": "Accept", "Start": "1:04.5", "End": "1:12.8", "Emotion": "Happy"},
			{"Name": "Main", "Start": "13:05.00", "End": "13:08.13", "Emotion": "Happy"},
			{"Name": "Accept", "Start": "1:12.8", "End": "0:74.1367797851563", "Emotion": "Happy"}, #TODO Broken
		],
		
		#CONFIRMED
		"OldMan": [
			{"Name": "Main", "Start": "13:09.22", "End": "13:10.44", "Emotion": "Happy"},
			{"Name": "OldMan", "Start": "2:05.2", "End": "2:09.3", "Emotion": "Happy"},
			{"Name": "Main", "Start": "13:11.21", "End": "13:17.04", "Emotion": "Angry"},
			{"Name": "OldMan", "Start": "2:10", "End": "2:19", "Emotion": "Happy"},
			{"Name": "Main", "Start": "13:18.05", "End": "13:19.07", "Emotion": ""},
		],
		
		
		"Rano": [
			{"Name": "Rano", "Start": "0", "End": "0", "Emotion": "Sad"},
		],
		"Leap": [
			{"Name": "Leap", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Hop": [
			{"Name": "Hop", "Start": "0", "End": "0", "Emotion": ""},
		],
		"Ribbit": [
			{"Name": "Ribbit", "Start": "0", "End": "0", "Emotion": ""},
		],
	},
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
]
var dialogue_voiceSpecific
var audioList = {
	"Talia": "res://Assets/DialogueVoice/Tutorial Talia.mp3",
	"Main": "res://Assets/DialogueVoice/MC.mp3",
	"Denial": "res://Assets/DialogueVoice/Denial Danny.mp3",
	"Anger": "res://Assets/DialogueVoice/Anger Angelica.mp3",
	"Bargin": "res://Assets/DialogueVoice/Bargaining Barry.mp3",
	"Depress": "res://Assets/DialogueVoice/Depression_Derick.mp3",
	"Accept": "res://Assets/DialogueVoice/Acceptence Antonio.mp3",
	"Croak": "res://Assets/DialogueVoice/Croak.mp3",
	"OldMan": "res://Assets/DialogueVoice/Old Man Tommy.mp3",
	"Rano": "res://Assets/DialogueVoice/LLE.mp3"
}

var emotionList = {
	"Talia": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"Main": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"Denial": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"Anger": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"Bargin": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"Depress": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"Accept": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"Croak": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"OldMan": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	
	"Rano": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"Leap": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"Hop": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"Ribbit": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
}
var load_audio
var audioCount = -1
	






















































func _ready():
	NPCname = null
	set_process_input(true)
	$PressForDialogue.text = RemapperData.get_keymap_name("Interaction")
	if GameData.day == 3:
		if $"../Bargin/Sprite2D" != null:
			$"../Bargin/Sprite2D".animation = "Barry_Sad"
	
	#Prompt the user to choose a discount on Day 5.
	if GameData.day == 5 and GameData.Discount == "" and GameData.current_ui == "":
		GameData.charLock = true
		GameData.current_ui = "dialogueSpecial"
		$PressForDialogue.visible = false
		$FixedDialoguePosition/CharacterIMG.visible = true
			
			
		$FixedDialoguePosition/AnimationPlayer.play("Dialogue_popup")
		dialogue_box.start("Day5")
		










func go_pos(delta):
	if moving and playerRuns == false: #Barry
		$"../Bargin".global_position = $"../Bargin".global_position.move_toward(BarryDestination, delta*moving_speed)
		$"../Bargin/FixedDialoguePosition/Voice".visible = false
		#Hide all character img
		$"../Bargin/FixedDialoguePosition/CharacterIMG".visible = false
		$FixedDialoguePosition/DialogueOpacity.visible = false
		$"../Bargin/StaticBody2D/CollisionShape2D".disabled = true
		$"../Bargin/Sprite2D".animation = "Barry_Running"
	elif moving and playerRuns == true: #Player
		$"../../Other/CharacterBody2D".global_position = $"../../Other/CharacterBody2D".global_position.move_toward(PlayerDestination, delta*moving_speed)
		$"../OldMan/FixedDialoguePosition/Voice".visible = false
		#Hide all character img (TODO Depends on who ends the call)
		$"../OldMan/FixedDialoguePosition/CharacterIMG".visible = false
		$"../OldMan/FixedDialoguePosition/DialogueOpacity".visible = false
		$FixedDialoguePosition/DialogueOpacity.visible = false
		$"../../Other/CharacterBody2D/CollisionShape2D".disabled = true
		
		$"../../Other/CharacterBody2D/Sprite2D".animation = "Right"
		
		emit_signal("leave_village")
		Utils.non_static_items_json.clear()
		Utils.non_static_items_json = Utils.non_static_items_json_FINAL.duplicate(true)
		
		GameData.day_8_count = 0
		GameData.QVillager = {}
		GameData.charLock = false
		if GameData.inventory_amount.keys().find("Twig") != -1:
			Utils.remove_from_inventory("Twig", int(GameData.inventory_amount["Twig"]))
		
		if GameData.inventory_amount.keys().find("Rock") != -1:
			Utils.remove_from_inventory("Rock", int(GameData.inventory_amount["Rock"]))
		
		if GameData.inventory_amount.keys().find("Sand") != -1:
			Utils.remove_from_inventory("Sand", int(GameData.inventory_amount["Sand"]))
		
		if GameData.inventory_amount.keys().find("Moss") != -1:
			Utils.remove_from_inventory("Moss", int(GameData.inventory_amount["Moss"]))
		
		if GameData.inventory_amount.keys().find("TinCan") != -1:
			Utils.remove_from_inventory("TinCan", int(GameData.inventory_amount["TinCan"]))
		
		if GameData.inventory_amount.keys().find("WaterBottle") != -1:
			Utils.remove_from_inventory("WaterBottle", int(GameData.inventory_amount["WaterBottle"]))
		
		
		#Reset villagers talked
		for i in range(len(GameData.villagersTalked)):
			GameData.villagersTalked[i]["Talked"] = false

		GameData.QMain = {}
		GameData.QMainLocationIdx = {}
		
		GameData.QWild = false
		GameData.questComplete = {"Main": false, "Wild": false}
		GameData.NPCgiveNoMore = false
		
		GameData.itemDialogue[0]["Value"] = 0
		GameData.itemDialogue[1]["Value"] = 0
		GameData.itemDialogue[2]["Value"] = 0
		GameData.itemDialogue[3]["Value"] = 0
		GameData.itemDialogue[4]["Value"] = 0
			
		#Reset take items and spawn again on the next day
		GameData.get_item_posX = null
		GameData.get_item_posY = null
		for i in range(len(GameData.itemSpawns)):
			GameData.itemSpawns[i]["Taken"] = false
		
		
		GameData.Discount = ""
		GameData.visitedWilderness == false
		
		GameData.madeProfit = false
		GameData.barryDespawned = false
		GameData.talkToKid = false
		GameData.leaveVillageQuest = false
		
		
		
		#TO Day 8 we go
		SoundControl.stop_playing()

		TextTransition.set_to_click(
			"You leave the village and come back the next day",
			"res://World Scene/World.tscn",
			"Click To Continue"
		)
		SceneTransition.change_scene("res://Globals/text_transition.tscn")
		if (GameData.day != 8): #Prevent the loop
			increase_day(1)
	
	
	if $"../Bargin".global_position == BarryDestination and playerRuns == false:
		moving = false
		$"../Bargin".position = Vector2(999999999, 999999999)
		GameData.charLock = false
		GameData.barryDespawned = true

		
func increase_day(amount):
	if(GameData.day+amount > 0):
		GameData.day += amount	
		
		
		
		
		
		
		


func _process(delta):
	
	#Wilderness exclusive
	if (NPCname == "Rano" or NPCname == "Leap" or NPCname == "Hop" or NPCname == "Ribbit") and dialogue_box.running:
		GameData.charLock = true
	
	#Day 5 Exclusive
	if not dialogue_box.running and GameData.day == 5 and GameData.Discount == "":
		GameData.charLock = true
	if GameData.Discount != "" and GameData.day == 5 and (GameData.current_ui == "dialogueSpecial"):
		GameData.current_ui = ""
		GameData.charLock = false
		$PressForDialogue.visible = false
		$FixedDialoguePosition/DialogueOpacity.visible = false
		$FixedDialoguePosition/CharacterIMG.texture = null
		$FixedDialoguePosition/CharacterIMG.visible = false
		$FixedDialoguePosition/Voice.visible = false
		print(GameData.current_ui)








	#Barry gone if he was gone before. This is for Day 3 only
	if (GameData.barryDespawned == true and $"../Bargin" != null):
		$"../Bargin".position = Vector2(999999999, 999999999)
	
	#Appear the game username in dialogue (Only Appears in NPC interaction)
	Utils.character_list.characters[0].name = GameData.username
	if dialogue_box.running:
		if ($FixedDialoguePosition/DialogueBox.speaker.text == GameData.username):
			$FixedDialoguePosition/CharacterIMG.texture = Utils.character_list.characters[0].image

	#Set the variables of the people that already talked to
	#This prevents a reset if the player visited the wilderness and comes back


	#TODO: If all the requests has been listed, we then save the Qmain
	#if GameData.QMain.values().size() >= 1:
		##Note that multiple requests is handled by the dialogue itself
		#dialogue_box.variables["QMain"] = true
	
	
	dialogue_box.variables["Profit?"] = GameData.madeProfit
	dialogue_box.variables["Discount"] = GameData.Discount
	for i in range(len(GameData.villagersTalked)):
		dialogue_box.variables[GameData.villagersTalked[i]["Name"]] = GameData.villagersTalked[i]["Talked"]
	
	
	#Items updating
	#TODO: Add more if needed
	dialogue_box.variables["Twigs"] = GameData.itemDialogue[0]["Value"]
	dialogue_box.variables["Rocks"] = GameData.itemDialogue[1]["Value"]
	dialogue_box.variables["WaterBottle"] = GameData.itemDialogue[2]["Value"]
	dialogue_box.variables["TinCans"] = GameData.itemDialogue[3]["Value"]
	dialogue_box.variables["WaterFilter"] = GameData.itemDialogue[4]["Value"]
	dialogue_box.variables["Well"] = GameData.well
	
	#TODO: Get the day for the appropriate dialogue
	#General for the kids since it is consistent
	if NPCname == "Rano" or NPCname == "Leap" or NPCname == "Hop" or NPCname == "Ribbit":
		dialogue_box.start_id = "LeapNoMore"
		
	if GameData.visitTutorial == true:
		dialogue_box.start_id = "TaliaTutorial"
	elif GameData.day == 1:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Denial"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Anger"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Bargin"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Depress"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Accept"
		elif NPCname == "Croak":
			dialogue_box.start_id = "Croak"
		elif NPCname == "OldMan":
			dialogue_box.start_id = "OldMan"
	elif GameData.day == 2:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Denial2"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Anger2"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Bargin2"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Depress2"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Accept2"
		elif NPCname == "Croak":
			dialogue_box.start_id = "Croak2"
		elif NPCname == "OldMan":
			dialogue_box.start_id = "OldMan2"
	elif GameData.day == 3:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Denial3"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Anger3"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Bargin3"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Depress3"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Accept3"
		elif NPCname == "Croak":
			dialogue_box.start_id = "Croak3"
		elif NPCname == "OldMan":
			dialogue_box.start_id = "OldMan3"
	elif GameData.day == 4:
		# Who is the player talking to?
		if NPCname == "Denial" and dialogue_box.variables["OldMan"] == true:
			dialogue_box.start_id = "Denial4"
		elif NPCname == "Anger" and dialogue_box.variables["OldMan"] == true:
			dialogue_box.start_id = "Anger4"
		elif NPCname == "Bargin" and dialogue_box.variables["OldMan"] == true:
			dialogue_box.start_id = "Bargin4"
		elif NPCname == "Depress" and dialogue_box.variables["OldMan"] == true:
			dialogue_box.start_id = "Depress4"
		elif NPCname == "Accept" and dialogue_box.variables["OldMan"] == true:
			dialogue_box.start_id = "Accept4"
		elif NPCname == "OldMan":
			dialogue_box.start_id = "OldMan4"
		elif NPCname == "Rano":
			dialogue_box.start_id = "Rano10"
		elif NPCname == "Ribbit":
			dialogue_box.start_id = "ThyRibbit"
		else:
			dialogue_box.start_id = "Day4"
	elif GameData.day == 5:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Denial5"
		elif NPCname == "Ribbit":
			dialogue_box.start_id = "ThyRibbit"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Anger5"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Bargin5"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Depress5"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Accept5"
		elif NPCname == "OldMan":
			var count = 0
			for i in range(len(GameData.villagersTalked)):
				if GameData.villagersTalked[i]["Talked"] == true:
					count = count + 1
			#We can talk to the old man if everyone has been talked to
			print(count)
			if count >= 5 and GameData.villagersTalked[6]["Talked"] == false:
				dialogue_box.start_id = "OldMan5"
			else:
				dialogue_box.start_id = "Day5OldMan"
	elif GameData.day == 6:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Denial6"
		elif NPCname == "Ribbit":
			dialogue_box.start_id = "ThyRibbit"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Anger6"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Bargin6"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Depress6"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Accept6"
		elif NPCname == "OldMan":
			dialogue_box.start_id = "OldMan6"
	elif GameData.day == 7:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Day7Negate"
		elif NPCname == "Ribbit":
			dialogue_box.start_id = "ThyRibbit"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Day7Negate"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Day7Negate"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Day7Negate"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Day7Negate"
		elif NPCname == "OldMan":
			if GameData.inventory_amount.keys().find("ReverseOsmosis") == -1:
				dialogue_box.start_id = "OldMan7"
			else:
				dialogue_box.start_id = "OldMan7FinishRO"
	elif GameData.day == 8:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Denial8"
		elif NPCname == "Ribbit":
			dialogue_box.start_id = "ThyRibbit"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Anger8"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Bargin8"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Depress8"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Accept8"
		elif NPCname == "OldMan":
			dialogue_box.start_id = "OldMan8"
	elif GameData.day == 9:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Denial9"
		elif NPCname == "Ribbit":
			dialogue_box.start_id = "ThyRibbit"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Anger9"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Bargin9"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Depress9"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Accept9"
		elif NPCname == "OldMan":
			dialogue_box.start_id = "OldMan9"
	elif GameData.day == 10:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Denial10"
		elif NPCname == "Ribbit":
			dialogue_box.start_id = "ThyRibbit"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Anger10"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Bargin10"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Depress10"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Accept10"
		elif NPCname == "OldMan":
			dialogue_box.start_id = "OldMan10"
			
			
		
	if moving:
		GameData.charLock = true
		go_pos(delta) #For barry
	
	
	if Input.is_action_just_pressed("Interaction") and enterBody == true and moving == false:
		#Focus the button that is visible on dialogue
		#for option in dialogue_box.options.get_children():
			#if option.visible:
				#print(true)
				#option.grab_focus()
				
		if GameData.current_ui != "dialogue" && GameData.current_ui != "":
			return
		if not dialogue_box.running:
			GameData.charLock = true
			GameData.current_ui = "dialogue"
			$PressForDialogue.visible = false
			$FixedDialoguePosition/CharacterIMG.visible = true
			
			
			$FixedDialoguePosition/AnimationPlayer.play("Dialogue_popup")
			dialogue_box.start()
			print("Begin")
			$FixedDialoguePosition/DialogueOpacity.visible = true
			print(dialogue_box)
	elif (not dialogue_box.running and enterBody == true):
		#or (not dialogue_box.running and dialogue_box.variables["Discount"] != ""
		GameData.charLock = false
		if GameData.current_ui == "dialogue":
			GameData.current_ui = ""
		$FixedDialoguePosition/DialogueOpacity.visible = false
		$FixedDialoguePosition/CharacterIMG.texture = null
		$FixedDialoguePosition/CharacterIMG.visible = false
		$FixedDialoguePosition/Voice.visible = false
		#$PressForDialogue.visible = true









func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		$PressForDialogue.visible = true
		enterBody = true
		NPCname = self.name
	else:
		NPCname = null
		dialogue_box.start_id = ""









func _on_body_exited(body):
	if (body.name == "CharacterBody2D"):
		print("Player has left")
		enterBody = false
		$PressForDialogue.visible = false
		GameData.current_ui = ""
		NPCname = null
		if dialogue_box.running:
			GameData.charLock = false
			dialogue_box.stop()
		dialogue_box.start_id = ""






func show_map_icon():
	$MapIcon.show()
	$Sprite2D.hide()
	if $PressForDialogue.visible:
		$PressForDialogue.hide()
		PressForDialogue_was_opened = true
		
	
func hide_map_icon():
	$Sprite2D.show()
	$MapIcon.hide()
	if PressForDialogue_was_opened:
		$PressForDialogue.show()
		PressForDialogue_was_opened = false

func show_notif(type):
	if type == "question":
		$Notif.texture = question
	else:
		$Notif.texture = exclamation
	$Notif.show()

func hide_notif():
	$Notif.hide()






func _on_dialogue_box_dialogue_ended():
	audioCount = -1 #Reset audio index
	$FixedDialoguePosition/CharacterIMG.visible = false
	
	#TODO
	#Run the loop and check true that we talked to that villager
	# This is for the requirement to leave the Day
	#Note that for Croak, you must talk to Barry.
	if GameData.day == 1 and GameData.visitTutorial == false:
		if NPCname == "Croak" and GameData.villagersTalked[2]["Talked"] == true:
			dialogue_box.variables[NPCname] = true
			print(dialogue_box.variables)
			for i in range(len(GameData.villagersTalked)):
				if GameData.villagersTalked[i]["Name"] == NPCname:
					GameData.villagersTalked[i]["Talked"] = true
		
		elif NPCname != "Croak":
			dialogue_box.variables[NPCname] = true
			print(dialogue_box.variables)
			for i in range(len(GameData.villagersTalked)):
				if GameData.villagersTalked[i]["Name"] == NPCname:
					GameData.villagersTalked[i]["Talked"] = true
	
	
	elif GameData.day == 3:
		if (NPCname != "Anger" and NPCname != "Depress"):
			dialogue_box.variables[NPCname] = true
			for i in range(len(GameData.villagersTalked)):
				if GameData.villagersTalked[i]["Name"] == NPCname:
					GameData.villagersTalked[i]["Talked"] = true
	
	
	elif GameData.day == 4:
		#Talk to the old man first
		if (dialogue_box.variables["OldMan"] == true or NPCname == "OldMan"):
			dialogue_box.variables[NPCname] = true
			for i in range(len(GameData.villagersTalked)):
				if GameData.villagersTalked[i]["Name"] == NPCname:
					GameData.villagersTalked[i]["Talked"] = true
	
	
	elif GameData.day == 5:
		var counts = 0
		for i in range(len(GameData.villagersTalked)):
			if GameData.villagersTalked[i]["Talked"] == true:
				counts = counts + 1
		#We can talk to the old man if everyone has been talked to
		#Talk to the old man first
		if (GameData.villagersTalked[6]["Talked"] == false and counts == 5):
			dialogue_box.variables[NPCname] = true
			for i in range(len(GameData.villagersTalked)):
				if GameData.villagersTalked[i]["Name"] == NPCname:
					GameData.villagersTalked[i]["Talked"] = true
		elif (NPCname != "OldMan" and (GameData.villagersTalked[0]["Talked"] == false or GameData.villagersTalked[1]["Talked"] == false or GameData.villagersTalked[2]["Talked"] == false or GameData.villagersTalked[4]["Talked"] == false or GameData.villagersTalked[5]["Talked"] == false)):
			dialogue_box.variables[NPCname] = true
			for i in range(len(GameData.villagersTalked)):
				if GameData.villagersTalked[i]["Name"] == NPCname:
					GameData.villagersTalked[i]["Talked"] = true
	elif GameData.day == 7:
		#Talk to the old man only
		if (NPCname == "OldMan"):
			dialogue_box.variables[NPCname] = true
			for i in range(len(GameData.villagersTalked)):
				if GameData.villagersTalked[i]["Name"] == NPCname:
					GameData.villagersTalked[i]["Talked"] = true
	
	
	elif GameData.day == 10:
		if (NPCname != "OldMan"):
			dialogue_box.variables[NPCname] = true
			for i in range(len(GameData.villagersTalked)):
				if GameData.villagersTalked[i]["Name"] == NPCname:
					GameData.villagersTalked[i]["Talked"] = true
	else:
		print(NPCname)
		dialogue_box.variables[NPCname] = true
		#GameData.QWild = dialogue_box.variables["QWild"]
		print(dialogue_box.variables)
		for i in range(len(GameData.villagersTalked)):
			if GameData.villagersTalked[i]["Name"] == NPCname:
				GameData.villagersTalked[i]["Talked"] = true
	
	
	
	
	
	
	
	#TODO: Quest stuff for the Main World
	#GameData.inventory_amount.keys().find("WaterBottle") != -1
	if (dialogue_box.variables["QMain"] == true and GameData.QVillager.keys().find(NPCname) == -1):
		dialogue_box.variables["QMain"] = false
		if GameData.QMain.keys().find(NPCname) == -1:
			GameData.QMain[NPCname] = false 
		GameData.QVillager[NPCname] = NPCname
	if (dialogue_box.variables["Profit?"] == true):
		GameData.madeProfit = true
	if (dialogue_box.variables["Discount"] != ""):
		GameData.Discount = dialogue_box.variables["Discount"]
	$PressForDialogue.visible = true
	dialogue_box.start_id = ""
	
	#This should be the ONLY case since the old man is the only person you are talking to
	if (NPCname == "OldMan" and GameData.day == 7 and GameData.inventory_amount.size() != 0):
		if (GameData.inventory_amount.keys().find("WaterBottleSpecial") != -1 or GameData.inventory_amount.keys().find("BoilingPot") != -1 or GameData.inventory_amount.keys().find("WaterFilter") != -1):
			print("Activate Union Hanger")
			$PressForDialogue.visible = false
			#Draw the items to display on screen
			#We allow the user to click on the item to learn more
			$NPCActions/OldManInventory/InventoryDialogue.draw_items(GameData.inventory)
			$NPCActions/OldManInventory.visible = true
			$FixedDialoguePosition/Voice.visible = true
	elif (NPCname == "OldMan" and GameData.day == 7 and oldManTempLock == false):
		#Continue with the dialogue
		dialogue_box.start("OldMan7Finish")
		GameData.charLock = true
		GameData.current_ui = "dialogue"
		$PressForDialogue.visible = false
		$FixedDialoguePosition/CharacterIMG.visible = true
		$FixedDialoguePosition/Voice.visible = true
		oldManTempLock = true #This can be reset, but should not affect anything
	#audioCount = 0












func _on_dialogue_box_dialogue_proceeded(node_type):
	#print($Dialogue/DialogueBox.speaker.text," addf")
	#TODO: Stop the voice recording if node proceeds
	
	#TODO: Set up the dialogue voices
	SoundControl.dialogue_audio_stop() #Stop the audio if next dialogue
	#print(audioCount)
	print("Dialogue Node: "+str(node_type))
	if NPCname != null:
		if str(node_type) == str(1):
			audioCount += 1
		if (audioCount < len(dialogue_voices[GameData.day - 1][NPCname])):
			print("Audio Count: "+str(audioCount))
			dialogue_voiceSpecific = dialogue_voices[GameData.day - 1][NPCname][audioCount]
	
	dialogue_box.custom_effects[0].skip = true
	dialogue_box.show_options()
	
	SoundControl.is_playing_sound("button")
	
	#TODO Fix cases where the username is the same as the NPCs
	if $FixedDialoguePosition/DialogueBox.speaker.text != "":
		var idx
		if Utils.char_dict.keys().find(str($FixedDialoguePosition/DialogueBox.speaker.text)) != -1:
			idx = Utils.char_dict[str($FixedDialoguePosition/DialogueBox.speaker.text)]
		else:
			#Its the main character
			idx = Utils.char_dict["Main"]
		#var CharacterVoice = audioList[dialogue_voiceSpecific["Emotion"]]
		#if (audioList[dialogue_voiceSpecific["Emotion"]] == ""):
			#$FixedDialoguePosition/CharacterIMG.texture = Utils.character_list.characters[idx].image
		#else: #Emotion
			#$FixedDialoguePosition/CharacterIMG.texture = Utils.character_list.characters[idx].image
		$FixedDialoguePosition/CharacterIMG.texture = Utils.character_list.characters[idx].image











func _on_dialogue_box_dialogue_signal(value):
	
	if value == "TaliaNo":
		audioCount = len(dialogue_voices[GameData.day - 1][NPCname]) - 3
	#Reference
	#if str(node_type) == str(1):
		#audioCount += 1
	#if (audioCount < len(dialogue_voices[GameData.day - 1][NPCname])):
		#print("Audio Count: "+str(audioCount))
		#dialogue_voiceSpecific = dialogue_voices[GameData.day - 1][NPCname][audioCount]
	
	#Dialogue Signals
	if value == "Negate":
		$FixedDialoguePosition/Voice.visible = true
	if value == "VoiceOff":
		$FixedDialoguePosition/Voice.visible = false
	if value == "EndIdx":
		audioCount = len(dialogue_voices[GameData.day - 1][NPCname]) - 2 #It is -1 based on length
		
	#Fixed Idx position
	if value == "Discount15%":
		audioCount = -1
	if value == "Discount35%":
		audioCount = 0
	if value == "Discount25%":
		audioCount = -1
	if value == "Discount40%":
		audioCount = 0
	
	if value == "RealignD1" or value == "RealignD2":
		audioCount = 1
	
	if value == "Day1Antonio":
		audioCount = 2
	if value == "AntonioRealign":
		audioCount = 3
	
	#Day 7 Old man signals
	if value == "OMBottle":
		audioCount = 5
	if value == "OMPot":
		audioCount = 6
	if value == "OMFilter":
		audioCount = 7
	
	if value == "OMRequest":
		audioCount = 8
	if value == "OMDone":
		audioCount = 11
	
	
	
	
	
	
	
	if value == "BarryRun":
		moving = true
	if value == "PlayerRun":
		moving = true
		playerRuns = true
		
	#Game completion (Day 10 Ending)
	if value == "FinishGame":
		TextTransition.set_to_chained_click(
			[
				"You've shown Old Man Tommy all the accomplishments you have made.",
				"You continued to help the village whenever you can.",
				"The company, Pure-Fi, eventually went bankrupt after the major protest that Angelica participated in.",
				"The End.",
			],
			"res://Main Menu Scene/credits.tscn",
			"Click To Continue"
		)
		SceneTransition.change_scene("res://Globals/text_transition.tscn")
	
	
	
	if value == "MainComplete":
		#audioCount = len(dialogue_voices[GameData.day - 1][NPCname]) - 1
		#GameData.questComplete["Main"] = true
		
		#Remove the items since we gave them
		#TODO: Add more days
		if GameData.NPCgiveNoMore == false:
			if GameData.day == 1:
				Utils.remove_from_inventory("Twig", 6)
				GameData.NPCgiveNoMore = true
			elif GameData.day == 2:
				Utils.remove_from_inventory("Rock", 4)
				GameData.NPCgiveNoMore = true
			elif GameData.day == 3:
				Utils.remove_from_inventory("TinCan", 3)
				GameData.NPCgiveNoMore = true
			elif GameData.day == 9:
				Utils.remove_from_inventory("TinCan", 6)
				GameData.NPCgiveNoMore = true
			elif GameData.day == 10:
				Utils.remove_from_inventory("Twig", 10)
				GameData.NPCgiveNoMore = true
			elif GameData.day == 8:
				if NPCname == "Bargin" and GameData.QMain["Bargin"] == false:
					Utils.remove_from_inventory("WaterBottle", 5)
				if NPCname == "Anger" and GameData.QMain["Anger"] == false:
					Utils.remove_from_inventory("WaterFilter", 2)
				if NPCname == "Denial" and GameData.QMain["Denial"] == false:
					Utils.remove_from_inventory("WaterBottle", 1)
			GameData.QMain[NPCname] = true
		
		var npcComplete = GameData.QMain.values()
		if not npcComplete.has(false):
			#All request has been fufill
			GameData.questComplete["Main"] = true
		



	if value == "TutorialEnded":
		Utils.remove_from_inventory("Rock", 1)
		GameData.QMain[NPCname] = true
		GameData.questComplete["Main"] = true
		TextTransition.set_to_click(
				"You then enter the village, excited for the opportunity to make profit.",
				"res://World Scene/World.tscn",
				"Click To Continue"
		)
		SceneTransition.change_scene("res://Globals/text_transition.tscn")

		GameData.day = 1

		GameData.inventory = []

		GameData.inventory_amount = {}

		#What is required to go to the next day
		GameData.inventory_requirement = {}

		GameData.charLock = false
		GameData.barryDespawned = false

		GameData.current_ui = ""
		GameData.current_scene = ""
		GameData.save_position = false
		GameData.player_position

		GameData.visitTutorial = false
		GameData.visitedWilderness = false
		GameData.talkToKid = false


		GameData.leaveVillageQuest = false



		#Dialogue related stuff

		GameData.QMain = {}
		GameData.QWild = false
		GameData.QMainLocationIdx = {}
		GameData.madeProfit = false
		GameData.NPCgiveNoMore = false #Give items once and not dup
		#Quest is finished
		GameData.questComplete = {"Main": false, "Wild": false}
		GameData.Discount = ""

		#TODO Add more if needed to stack of the items needed for NPC
		GameData.itemDialogue = [
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
			},
			{
				"Name": "WaterFilter",
				"Value": 0
			}
		]

		GameData.QVillager = {}

		GameData.villagersIndex = {
			"Accept": 0,
			"Anger": 1,
			"Bargin": 2,
			"Croak": 3,
			"Denial": 4,
			"Depress": 5,
			"OldMan": 6,
			"Talia": 7,
			
			"Rano": 8,
			"Ribbit": 9,
			"Hop": 10,
			"Leap": 11
		}

		GameData.villagersTalked = [
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
			},
			{
				"Name": "Talia",
				"Talked": false
			}
		]

	
























func _on_animation_player_animation_finished(anim_name):
	if $FixedDialoguePosition/DialogueBox.speaker.text != "":
		$FixedDialoguePosition/Voice.visible = true
	dialogue_box.show_options()


func _on_voice_pressed():
	print("Play Voice Recording")
	var CharacterVoice = audioList[dialogue_voiceSpecific["Name"]]
	##TODO: PLay audio
	SoundControl.play_audio(CharacterVoice, dialogue_voiceSpecific["Start"], dialogue_voiceSpecific["End"]) # Node, string, int, int
	dialogue_box.show_options()
