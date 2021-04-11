Class {
	#name : #Tests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
Tests >> testDummy [
	"a dummy test comment"
	"un dia en un cementerio de pizzas habian 2 pizzas"
	self assert: Dummy new isDummy
]
