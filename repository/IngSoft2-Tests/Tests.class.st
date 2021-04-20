Class {
	#name : #Tests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
Tests >> test000_CreateABoard [
	"a dummy test comment"
	"un dia en un cementerio de pizzas habian 2 pizzas"
	| myBoard myDie laQueHablaRaro myPlayers |
	
	laQueHablaRaro:= Player withName: 'laQueHablaRaro'.
	self assert: (laQueHablaRaro location) equals:0.
	
	myDie := OrderedCollection with: (Dice withSides: 1).
	
	myPlayers:= (OrderedCollection with: laQueHablaRaro).
	
	myBoard:= Board withSize:10 andPlayers: myPlayers andDie: myDie.
	
	self assert: (myBoard sizeOfBoard) equals: 10.

	self assert: (myBoard players) equals: myPlayers.
	
	self assert: (myBoard die) equals: myDie.
	
]

{ #category : #tests }
Tests >> test001_invalidBoardValuesRaiseError [
	"a dummy test comment"
	"un dia en un cementerio de pizzas habian 2 pizzas"
	| myBoard myDie laQueHablaRaro boardWithoutPlayers boardWithoutDie|
	
	laQueHablaRaro:= Player withName: 'laQueHablaRaro'.
	self assert: (laQueHablaRaro location) equals:0.
	
	myDie := OrderedCollection with: (Dice withSides: 1).
	
	myBoard:= Board withSize:0 andPlayers: (OrderedCollection with: laQueHablaRaro) andDie: myDie.
	
	self should: [myBoard sizeOfBoard] raise: Error.
	
	boardWithoutPlayers  := Board withSize:1 andPlayers: (OrderedCollection new) andDie: myDie.
	self should: [boardWithoutPlayers  player] raise: Error.
	
	boardWithoutDie  := Board withSize:0 andPlayers: (OrderedCollection with: laQueHablaRaro) andDie: 	(OrderedCollection new).
	self should: [boardWithoutDie die] raise: Error.
	
	
]

{ #category : #tests }
Tests >> test002_CreateAPlayer [
	| myPlayer |
	myPlayer := Player withName: 'Push-Pop :)'.
	self assert: (myPlayer location) equals:0.
	self assert: (myPlayer name) equals: 'Push-Pop :)'.
]

{ #category : #tests }
Tests >> test003_CreateAPlayerWithNLocationAndName [
	| myPlayer |
	myPlayer := Player withLocation: 6 andName: 'Pizza Mediana'.
	self assert: (myPlayer location) equals:6.
	self assert: (myPlayer name ) equals: 'Pizza Mediana'.
		
	myPlayer := Player withLocation: 7 andName: 'Pizza Napolitana'.
	self assert: (myPlayer location) equals:7.
	self assert: (myPlayer name ) equals: 'Pizza Napolitana'.
]

{ #category : #tests }
Tests >> test004_CreateADiceWithNSides [
	| myDice mySecondDice |
	myDice := Dice withSides: 6.
	self assert: (myDice sides) equals:6.
	
	mySecondDice := Dice withSides: 0.
	self should: [mySecondDice sides] raise: Error.
	"self should: [mySecondDice sides] raise: Error description: ('No existen los dados de 0 lados')."
]

{ #category : #tests }
Tests >> test005_APlayerTossesADice [
"Un jugador tira un dado- su ubicacion cambia de acuerdo al numero que sacó"
	| myPlayer myDie |
	
	myPlayer := Player withName: 'Pizza Hawaiana'.
	self assert: (myPlayer location) equals:0.
	
	myDie:=OrderedCollection with: (Dice withSides: 6) with: (Dice withSides: 4).
	
	self assert: ((myDie at:1) sides) equals:6.
	self assert: ((myDie at:2) sides) equals:4.
	
	myPlayer tosses: myDie.
	
	self deny: (myPlayer location) equals:0.
]

{ #category : #tests }
Tests >> test006_CreateAGameSinglePlayer [
	
	| myBoard myDie laQueHablaRaro positions |
	
	laQueHablaRaro:= Player withName: 'laQueHablaRaro'.
	self assert: (laQueHablaRaro location) equals:0.
	
	myDie := OrderedCollection with: (Dice withSides: 1).
	
	myBoard:= Board withSize: 5 andPlayers: (OrderedCollection with: laQueHablaRaro) andDie: myDie.
	
	positions:= myBoard play.
	self deny: (laQueHablaRaro location) equals:0.
	self assert: (myBoard isFinished).
	self assert: ((positions at:1) equals: laQueHablaRaro).
	
]

{ #category : #tests }
Tests >> test007_CreateAGameMultiPlayer [
	
	| myBoard myDie napolitana positions margarita testPlayers mozzarella |
	
	napolitana:= Player withLocation: 5 andName: 'Ana Bolena'.
	self assert: (napolitana location) equals:5.
	
	margarita:= Player withLocation: 0 andName: 'Ben Reilly'.
	self assert: (margarita location) equals:0.

	mozzarella:= Player withLocation: 1 andName: 'María Antonietta'.
	self assert: (mozzarella location) equals:1.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	myDie := OrderedCollection with: (Dice withSides: 1).
	
	myBoard:= Board withSize: 10 andPlayers: testPlayers andDie: myDie.
	
	positions:= myBoard play.
	self assert: (napolitana location) equals:10.
	self assert: (margarita location) equals:4.
	self assert: (mozzarella location) equals:5.
	self assert: (myBoard isFinished).
	self assert: ((positions at:1) equals: napolitana).
	self assert: ((positions at:2) equals: mozzarella).
	self assert: ((positions at:3) equals: margarita).
	
]
