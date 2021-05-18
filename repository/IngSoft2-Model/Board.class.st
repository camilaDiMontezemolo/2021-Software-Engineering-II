Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'mySize',
		'myBoxes'
	],
	#category : #'IngSoft2-Model'
}

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
	| box |
	box := myBoxes at: (aPosition location+1).
	box affect: gamePositions triggeredOn: aPosition with: mySize
]

{ #category : #'as yet unclassified' }
Board >> boxes [
	^myBoxes.
]

{ #category : #'as yet unclassified' }
Board >> change: aPosition rolling: myDie [
	| distance |
	distance := 0.
	myDie do: [ :dice | distance := distance + dice spin ].	
	(aPosition  location + distance <= mySize)
		ifTrue: [ 
			aPosition changeLocation: aPosition location + distance.]
		ifFalse: [
			aPosition
			changeLocation: distance - (mySize - aPosition location).
			aPosition increaseLap.
			].
		
	
		
]

{ #category : #'as yet unclassified' }
Board >> initialize [
	mySize :=0.
	myBoxes := OrderedCollection new.
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
Board >> sizeOfBoard [
	^mySize.
]
