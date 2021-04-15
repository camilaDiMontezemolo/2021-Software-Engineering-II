Class {
	#name : #Tests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
Tests >> test001_CreateABoard [
	"a dummy test comment"
	"un dia en un cementerio de pizzas habian 2 pizzas"
	| myBoard |
	myBoard := Board new.
	self assert: (myBoard sizeOfBoard) equals: 0.
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
	| myDice |
	myDice := Dice withSides: 6.
	self assert: (myDice sides) equals:6
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
	
	| myBoard myDie napolitana positions margarita testPlayers |
	
	napolitana:= Player withLocation: 5 andName: 'Ana Bolena'.
	self assert: (napolitana location) equals:5.
	
	margarita:= Player withLocation: 0 andName: 'Ben Reilly'.
	self assert: (margarita location) equals:0.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita.
	
	myDie := OrderedCollection with: (Dice withSides: 1).
	
	myBoard:= Board withSize: 10 andPlayers: testPlayers andDie: myDie.
	
	positions:= myBoard play.
	self assert: (napolitana location) equals:10.
	self assert: (margarita location) equals:4.
	self assert: (myBoard isFinished).
	self assert: ((positions at:1) equals: napolitana).
	self assert: ((positions at:2) equals: margarita).
	
]
