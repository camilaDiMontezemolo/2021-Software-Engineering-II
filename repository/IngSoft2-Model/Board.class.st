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
	indice := 0.
	[indice < (mySize *aPercentage ) and: (myBoxes size < mySize)]
		whileTrue:[ myBoxes add: aBoxType new.
			indice = (indice +1) ].
]

{ #category : #'as yet unclassified' }
Board >> boxes [
	^myBoxes.
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
	self add: 0.48 of: NoEffectBox.
	self add: 0.2 of: SpeedupBox.
	self add: 0.2 of: WormHoleBox.
	self add: 0.1 of: MoonWalkBox.
	self add: 0.02 of: AtomicBombBox.
	
]

{ #category : #'as yet unclassified' }
Board >> sizeOfBoard [
	^mySize.
]
