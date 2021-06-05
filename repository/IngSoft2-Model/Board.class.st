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

{ #category : #instanceCreation }
Board class >> withBoxes: aCollectionOfBoxes andLaps: laps [.
	^self new initializeWithBoxes: aCollectionOfBoxes andLaps: laps.
]

{ #category : #'instance creation' }
Board class >> withSize: aSize [
	(aSize < 1 ) ifTrue: [ Error signal: 'Un tablero no puede tener menos de 1 casillero.' ].
	^self new initializeWithSize: aSize.
]

{ #category : #'instance creation' }
Board class >> withSize: aSize andLaps: laps [
	(aSize < 1 ) ifTrue: [ Error signal: 'Un tablero no puede tener menos de 1 casillero.' ].
	^self new initializeWithSize: aSize andLaps: laps.
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
	newLocations := box
		affect: gamePositions
		triggeredOn: aPosition
		with: mySize.
	self replacePositionsUsing: newLocations
]

{ #category : #'as yet unclassified' }
Board >> boxes [
	^myBoxes.
]

{ #category : #'as yet unclassified' }
Board >> change: aPosition rolling: myDie [
	| distance pos |
	distance := 0.
	myDie do: [ :dice | distance := distance + dice spin ].
	pos:= (aPosition absoluteLocation) +distance.
	^(self generatePositionFor: aPosition at: pos).
	"(aPosition  location + distance <= mySize)
		ifTrue: [ 
			aPosition changeLocation: aPosition location + distance.]
		ifFalse: [
			aPosition
			changeLocation: distance - (mySize - aPosition location).
			aPosition increaseLap.
			]."
		
	
		
]

{ #category : #'as yet unclassified' }
Board >> change: aPosition using: myDie playing: game [
	|newPosition|
	newPosition := self change: aPosition rolling: myDie.
	(game isFinished)
			ifTrue: [ self replacePosition: aPosition  with: newPosition]
			ifFalse: [self applyEffectFor: aPosition and: positions.].
	(game isFinished)
			ifTrue: [ self replacePosition: aPosition  with: newPosition ]
]

{ #category : #'as yet unclassified' }
Board >> createPositionsFor: players [
	positions:= players collect: [ :player | (Position of: player at: 0)].
]

{ #category : #'as yet unclassified' }
Board >> findBoxFor: aPosition [
	^ myBoxes
		at:
			(aPosition absoluteLocation
				- (mySize * (aPosition absoluteLocation // mySize))+1)
]

{ #category : #'as yet unclassified' }
Board >> generatePositionFor: aPosition at: absoluteLocation [
	^(Position of: (aPosition player) at: absoluteLocation).
]

{ #category : #'as yet unclassified' }
Board >> initialize [
	mySize :=0.
	myBoxes := OrderedCollection new.
]

{ #category : #initialize }
Board >> initializeWithBoxes: aCollectionOfBoxes [ 
	myBoxes := aCollectionOfBoxes.
	myBoxes addFirst: (BoxNoEffect new).
	mySize := ( (myBoxes size)-1 ).
]

{ #category : #initialize }
Board >> initializeWithBoxes: aCollectionOfBoxes andLaps: laps [
	myBoxes := aCollectionOfBoxes.
	myBoxes addFirst: (BoxNoEffect new).
	mySize := ( (myBoxes size)-1 ).
	mylaps := laps.
]

{ #category : #'as yet unclassified' }
Board >> initializeWithSize: aSize [
	mySize := aSize.
	myBoxes := OrderedCollection new.
	self add: 0.48 of: BoxNoEffect.
	self add: 0.2 of: BoxSpeedup.
	self add: 0.2 of: BoxWormHole.
	self add: 0.1 of: BoxMoonWalk.
	self add: 0.02 of: BoxAtomicBomb.
	(myBoxes size < mySize)
		ifTrue: [ 
			(myBoxes size) to: (mySize) do: [:emptyBox | myBoxes add: (BoxNoEffect new) ].
		].
	myBoxes := myBoxes shuffled.
	myBoxes addFirst: (BoxNoEffect new).
	
]

{ #category : #'as yet unclassified' }
Board >> initializeWithSize: aSize andLaps: laps [
	mySize := aSize.
	myBoxes := OrderedCollection new.
	self add: 0.48 of: BoxNoEffect.
	self add: 0.2 of: BoxSpeedup.
	self add: 0.2 of: BoxWormHole.
	self add: 0.1 of: BoxMoonWalk.
	self add: 0.02 of: BoxAtomicBomb.
	(myBoxes size < mySize)
		ifTrue: [ 
			(myBoxes size) to: (mySize) do: [:emptyBox | myBoxes add: (BoxNoEffect new) ].
		].
	myBoxes := myBoxes shuffled.
	myBoxes addFirst: (BoxNoEffect new).
	mylaps:=laps.
	
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
		(Position of: (position player) at: (newLocations at: position))].
	
		
]

{ #category : #'as yet unclassified' }
Board >> sizeOfBoard [
	^mySize.
]
