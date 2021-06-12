Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'mySize',
		'myBoxes',
		'positions',
		'mylaps',
		'lastBoxUsed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
Board class >> withBoxes: aCollectionOfBoxes [
	^self new initializeWithBoxes: aCollectionOfBoxes.
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
Board >> change: aPosition for: distance [
	| pos |
	pos:= (aPosition absoluteLocation) +distance.
	^(self generatePositionFor: aPosition at: pos).
		
	
		
]

{ #category : #'as yet unclassified' }
Board >> change: aPosition using: distance playing: game [
	|newPosition|
	newPosition := self change: aPosition for: distance.
	self replacePosition: aPosition  with: newPosition.
	(game isFinished)
			ifFalse: [self applyEffectFor: newPosition].
	"(game isFinished)
			ifTrue: [ self replacePosition: aPosition  with:  ]"
]

{ #category : #'as yet unclassified' }
Board >> createPositionsFor: players [
	positions:= players collect: [ :player | (Position of: player at: 0)].
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
Board >> initializeWithBoxes: aCollectionOfBoxes [ 
	myBoxes := OrderedCollection new.
	myBoxes := aCollectionOfBoxes.
	myBoxes addFirst: (NoEffectBox new).
	mySize := ( (myBoxes size)-1 ).
	lastBoxUsed := (NoEffectBox new).
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
Board >> sizeOfBoard [
	^mySize.
]
