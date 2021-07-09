Class {
	#name : #BoxGenerator,
	#superclass : #Object,
	#classVars : [
		'myBoxes',
		'mySize'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoxGenerator class >> give: aSize [
	self validateSize: aSize.
	^ self new initializeWithSize: aSize
]

{ #category : #'instance creation' }
BoxGenerator class >> validateSize: aSize [
	aSize < 1
		ifTrue: [ Error signal: 'Un tablero no puede tener menos de 1 casillero.' ]
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

{ #category : #initalize }
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
	^myBoxes.
	
]
