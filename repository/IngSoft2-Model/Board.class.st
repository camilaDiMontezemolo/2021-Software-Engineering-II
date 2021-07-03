Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'mySize',
		'myBoxes',
		'positions',
		'mylaps',
		'lastBoxUsed',
		'cardsForGame',
		'myPlayers',
		'myGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
Board class >> withBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame [
	^self new initializeWithBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame.
]

{ #category : #'instance creation' }
Board class >> withSize: aSize [
	(aSize < 1 ) ifTrue: [ Error signal: 'Un tablero no puede tener menos de 1 casillero.' ].
	^self new initializeWithSize: aSize.
]

{ #category : #'as yet unclassified' }
Board >> applyEffectFor: aPosition [
	| box |
	box := self findBoxFor: aPosition.
	box affect: positions triggeredOn: aPosition with: self.
	lastBoxUsed:=box.
]

{ #category : #'as yet unclassified' }
Board >> applyLastTypeOfBoxFor: aPlayer [ 
	| positionOfPlayer |
	positionOfPlayer := (self findPositionOfPlayer: aPlayer) at:1.
	lastBoxUsed affect: positions triggeredOn: positionOfPlayer with: self. 
]

{ #category : #'as yet unclassified' }
Board >> calculateNewLocationFor: position [
	|laps|
	laps:= ((position absoluteLocation)//(mySize)).
	
	(laps ==0)
	ifTrue:[^0.]
	ifFalse:[^(mySize*laps)+1.].
]

{ #category : #'as yet unclassified' }
Board >> cardsForGame [
	^cardsForGame.
]

{ #category : #'as yet unclassified' }
Board >> change: aPosition by: distance [
	| newAbsolute newPosition|
   newAbsolute:= (aPosition absoluteLocation) +distance.
	newPosition:= (self generatePositionFor: aPosition at: newAbsolute).
	self replacePosition: aPosition with: newPosition.
   ^newPosition.
		
	
		
]

{ #category : #'as yet unclassified' }
Board >> changePositionOf: aPlayer by: distance playing: game [
	|newPosition playerPosition|
	playerPosition:= (positions select: [:position | position player= aPlayer ]) first.
	newPosition := self change: playerPosition by: distance.
	(game isFinished)
			ifFalse: [self applyEffectFor: newPosition].
]

{ #category : #'as yet unclassified' }
Board >> createPositions [
	positions:= myPlayers collect: [ :player | (Position of: player at: 0 on: self)].
]

{ #category : #'as yet unclassified' }
Board >> findBoxFor: aPosition [
	^ myBoxes at:
			((aPosition absoluteLocation) - (mySize*((aPosition absoluteLocation)//mySize)))+1.
]

{ #category : #'as yet unclassified' }
Board >> findPositionOfPlayer: aPlayer [
	^(positions select: [: position| (position player)=aPlayer])
]

{ #category : #'as yet unclassified' }
Board >> generatePositionFor: aPosition at: absoluteLocation [
	^(Position of: (aPosition player) at: absoluteLocation).
]

{ #category : #initialize }
Board >> initializeWithBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame [
	myBoxes := OrderedCollection new.
	myBoxes := aCollectionOfBoxes.
	myBoxes addFirst: (NoEffectBox new).
	mySize := ( (myBoxes size)-1 ).
	lastBoxUsed := (NoEffectBox new).
	cardsForGame := OrderedCollection new.
	myPlayers:= somePlayers.
	myGame:=aGame.
]

{ #category : #'as yet unclassified' }
Board >> newCardswereAdded: newCards [
	cardsForGame:= newCards. 
]

{ #category : #'as yet unclassified' }
Board >> positions [
	^positions.
]

{ #category : #'as yet unclassified' }
Board >> replacePosition: position with: newPosition [
	positions at:(positions indexOf: position) put: newPosition.
]

{ #category : #'as yet unclassified' }
Board >> resetBoxCards [
	cardsForGame removeAll.
]

{ #category : #'as yet unclassified' }
Board >> sizeOfBoard [
	^mySize.
]
