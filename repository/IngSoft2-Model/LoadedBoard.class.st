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
LoadedBoard >> applyEffectFor: aPlayer [
	| box affectedPlayers myPlayers myBoard |
	box := myBoxes at: (aPlayer location+1).
	(box isKindOf: MultVictimBox)
		ifTrue: [ 
			affectedPlayers:= myPlayers.
			(box isKindOf: MoonWalkBox) 
				ifTrue: [ 
					affectedPlayers:= 
						(myPlayers select: 
							[:player| 
								(player equals: aPlayer) not
							]
						)
				].
			box affect: affectedPlayers and: myBoard
			]
		ifFalse: [ box affect: aPlayer and: myBoard ].
	
		
]

{ #category : #'as yet unclassified' }
LoadedBoard >> applyEffectFor: aPosition and: otherPositions [
	| box affectedPositions |
	box := myBoxes at: (aPosition location+1).
	(box isKindOf: MultVictimBox)
		ifTrue: [ 
			affectedPositions:= otherPositions .
			(box isKindOf: MoonWalkBox) 
				ifTrue: [ 
					affectedPositions:= 
						(otherPositions  select: 
							[:position| 
								(position equals: aPosition) not
							]
						)
				].
			box affect: affectedPositions and: self
			]
		ifFalse: [ box affect: aPosition and: self ].
	
		
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
	myBoxes addFirst: (NoEffectBox new).
	mySize := ( (myBoxes size)-1 )
	"Y el menos no se saca".
	
		
]

{ #category : #'as yet unclassified' }
LoadedBoard >> sizeOfBoard [
	^mySize.
	
		
]
