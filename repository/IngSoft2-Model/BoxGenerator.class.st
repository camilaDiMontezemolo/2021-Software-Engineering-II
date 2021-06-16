Class {
	#name : #BoxGenerator,
	#superclass : #Object,
	#classVars : [
		'myBoxes',
		'mySize'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
BoxGenerator class >> give: aSize [
	(aSize < 1 ) ifTrue: [ Error signal: 'Un tablero no puede tener menos de 1 casillero.' ].
	^self new initializeWithSize: aSize.

]

{ #category : #'as yet unclassified' }
BoxGenerator >> add: aPercentage of: aBoxType [
	| indice |
	indice := 1.
	[(indice <= (mySize *aPercentage)) & (myBoxes size < mySize)]
		whileTrue:[
			myBoxes add: (aBoxType new).
			indice := (indice +1).
			].
		
]

{ #category : #'as yet unclassified' }
BoxGenerator >> initializeWithSize: aSize [
	mySize := (aSize-1).
	myBoxes := OrderedCollection new.
	self add: 0.48 of: NoEffectBox.
	self add: 0.2 of: SpeedupBox.
	self add: 0.2 of: WormHoleBox.
	self add: 0.1 of: MoonWalkBox.
	self add: 0.02 of: AtomicBombBox.
	self add: 0.1 of: CardBox.
	(myBoxes size < mySize)
		ifTrue: [ 
			(myBoxes size) to: (mySize) do: [:emptyBox | myBoxes add: (NoEffectBox new) ].
		].
	myBoxes := myBoxes shuffled.
	"myBoxes addFirst: (NoEffectBox new)."
	^myBoxes.
	
]
