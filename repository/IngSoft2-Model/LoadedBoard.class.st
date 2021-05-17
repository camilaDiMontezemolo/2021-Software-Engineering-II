Class {
	#name : #LoadedBoard,
	#superclass : #Object,
	#instVars : [
		'myBoxes',
		'mySize'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
LoadedBoard class >> withBoxes: someBoxes [
	^self new initializeWithBoxes: someBoxes.
]

{ #category : #'as yet unclassified' }
LoadedBoard >> applyEffectFor: aPosition and: gamePositions [
	| box |
	box := myBoxes at: (aPosition location+1).
	box affect: gamePositions triggeredOn: aPosition with: mySize
	
		
]

{ #category : #'as yet unclassified' }
LoadedBoard >> boxes [
	^myBoxes.
	
		
]

{ #category : #'as yet unclassified' }
LoadedBoard >> change: aPosition rolling: myDie [
	| distance |
	distance := 0.
	myDie do: [ :dice | distance := distance + dice spin ].	
	(aPosition  location + distance <= mySize)
		ifTrue: [ 
			aPosition changeLocation: aPosition location + distance.]
		ifFalse: [
			aPosition
			changeLocation: distance - (mySize - aPosition location).
			aPosition changeLap.
			].
	
		
]

{ #category : #'as yet unclassified' }
LoadedBoard >> initialize [
	mySize :=0.
	myBoxes := OrderedCollection new.
	
		
]

{ #category : #'as yet unclassified' }
LoadedBoard >> initializeWithBoxes: someBoxes [
	myBoxes := someBoxes.
	myBoxes addFirst: (BoxNoEffect new).
	mySize := ( (myBoxes size)-1 )
	"Y el menos no se saca".
	
		
]

{ #category : #'as yet unclassified' }
LoadedBoard >> sizeOfBoard [
	^mySize.
	
		
]
