Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'mySize',
		'myBoxes',
		'positions',
		'mylaps'
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
Board >> add: aPercentage of: aBoxType [
	| indice |
	indice := 1.
	[(indice <= (mySize *aPercentage)) & (myBoxes size < mySize)]
		whileTrue:[
			myBoxes add: (aBoxType new).
			indice := (indice +1).
			].
		
]

{ #category : #'as yet unclassified' }
Board >> applyEffectFor: aPosition and: gamePositions [
	| box newLocations |
	box := self findBoxFor: aPosition.
	newLocations := box affect: gamePositions triggeredOn: aPosition with: self.
	self replacePositionsUsing: newLocations
]

{ #category : #'as yet unclassified' }
Board >> boxes [
	^myBoxes.
]

{ #category : #'as yet unclassified' }
Board >> calculateNewLocationFor: position [
	|laps|
	
	laps:= ((position absoluteLocation)//(mySize)).
	(laps ==0)
	ifTrue:[
		^0.		
	]
	ifFalse:[
		^(mySize*laps)+1.
	].
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
			ifFalse: [self applyEffectFor: newPosition and: positions.].
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
			"((aPosition absoluteLocation- mySize *(aPosition absoluteLocation//mySize))+1)".
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
]

{ #category : #'as yet unclassified' }
Board >> initializeWithSize: aSize [
	mySize := aSize.
	myBoxes := OrderedCollection new.
	self add: 0.48 of: NoEffectBox.
	self add: 0.2 of: SpeedupBox.
	self add: 0.2 of: WormHoleBox.
	self add: 0.1 of: MoonWalkBox.
	self add: 0.02 of: AtomicBombBox.
	(myBoxes size < mySize)
		ifTrue: [ 
			(myBoxes size) to: (mySize) do: [:emptyBox | myBoxes add: (NoEffectBox new) ].
		].
	myBoxes := myBoxes shuffled.
	myBoxes addFirst: (NoEffectBox new).
	
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
Board >> replacePositionsUsing: newLocations [
	positions do: [:position | self replacePosition: position with:
		(Position of: (position player) at: 
		(newLocations at: position ifAbsent: [position absoluteLocation]))].
	
		
]

{ #category : #'as yet unclassified' }
Board >> sizeOfBoard [
	^mySize.
]
