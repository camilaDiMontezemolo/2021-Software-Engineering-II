Class {
	#name : #Tests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
Tests >> testAPlayerTossesADice [
"Un jugador tira un dado- su ubicacion cambia de acuerdo al numero que sacó"
	| myPlayer myDie |
	
	myPlayer := Player new.
	self assert: (myPlayer location) equals:0.
	
	myDie:=OrderedCollection with: (Dice withSides: 6) with: (Dice withSides: 4).
	
	self assert: ((myDie at:1) sides) equals:6.
	self assert: ((myDie at:2) sides) equals:4.
	
	myPlayer tosses: myDie.
	
	self deny: (myPlayer location) equals:0.
]

{ #category : #tests }
Tests >> testCreateABoard [
	"a dummy test comment"
	"un dia en un cementerio de pizzas habian 2 pizzas"
	| myBoard |
	myBoard := Board new.
	self assert: (myBoard sizeOfBoard) equals: 0.
]

{ #category : #tests }
Tests >> testCreateABoardWithSize [
	| myBoard |
	myBoard := Board withSize: 5.
	self assert: (myBoard sizeOfBoard) equals: 5.
]

{ #category : #tests }
Tests >> testCreateADice [
	| myDice |
	myDice := Dice new.
	self assert: (myDice sides) equals:0
]

{ #category : #tests }
Tests >> testCreateADiceWithNSides [
	| myDice |
	myDice := Dice withSides: 6.
	self assert: (myDice sides) equals:6
]

{ #category : #tests }
Tests >> testCreateAPlayer [
	| myPlayer |
	myPlayer := Player new.
	self assert: (myPlayer location) equals:0
]

{ #category : #tests }
Tests >> testCreateAPlayerWithNLocation [
	| myPlayer |
	myPlayer := Player withLocation: 6.
	self assert: (myPlayer location) equals:6.
	
	myPlayer := Player withLocation: 7.
	self assert: (myPlayer location) equals:7.
]

{ #category : #tests }
Tests >> testDummy [
	"a dummy test comment"
	"un dia en un cementerio de pizzas habian 2 pizzas"
	self assert: Dummy new isDummy
]
