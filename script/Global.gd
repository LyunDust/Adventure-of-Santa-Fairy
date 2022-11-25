#Owner: LeeSoyoung
extends Node

var presentNum = 0 #Variables to store the number of presents left
var playerDie = false #Variables that check that the player is alive. It's also related to blinking effects
var aiming = false #Variable to determine if the player is aiming
var target = false #Variables that check that the player has successfully aimed
var toyArrive = false #Variable to determine if item2 thrown by the player has arrived at the target position
var toyCount = 0 #Variable to count the number of item2s thrown
var vaccumsPos #Variable to store the position of the robot vacuum that changes continuously
