Class {
	#name : #BoxGenerator,
	#superclass : #Object,
	#instVars : [
		'size',
		'percentages',
		'boxCollection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoxGenerator class >> give: aSize for: boxTypes with: probabilities [.
	self validate: probabilities.
	^ self new initializeWithSize: aSize for: boxTypes with: probabilities.
]

{ #category : #'instance creation' }
BoxGenerator class >> validate: probabilities [
	| sum |
	sum := 0. 
	probabilities do: [:oneProba | sum := sum + oneProba].
	(sum = 1)
	ifFalse: [ Error signal: 'Las suma de probabilidades debe ser 1.'  ]
]

{ #category : #'set up' }
BoxGenerator >> add: aPercentage of: aBoxType [
	| indice |
	indice := 1.
	[(indice <= (size *aPercentage)) & (boxCollection size < size)] whileTrue:[
			boxCollection add: aBoxType new.
			indice := indice +1.].
	boxCollection := boxCollection shuffled.
	^boxCollection.
		 
]

{ #category : #'set up' }
BoxGenerator >> completeBoard [
	(boxCollection size < size)
		ifTrue: [ (boxCollection size) to: (size) do: [:emptyBox | boxCollection add: (NoEffectBox new) ].	].
]

{ #category : #'set up' }
BoxGenerator >> createBoardFor: boxTypes with: probabilities [
	| index |
	index := 1.
	[ index <= boxTypes size ]
		whileTrue: [ self add: (probabilities at: index) of: (boxTypes at: index).
			index := index + 1 ]
]

{ #category : #initalize }
BoxGenerator >> initializeWithSize: aSize for: boxTypes with: probabilities [
	size := aSize - 1.
	boxCollection := OrderedCollection new.
	self createBoardFor: boxTypes with: probabilities.
	self completeBoard.
	^ boxCollection.
]
