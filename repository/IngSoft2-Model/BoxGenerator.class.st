Class {
	#name : #BoxGenerator,
	#superclass : #Object,
	#instVars : [
		'size',
		'percentages',
		'boxCol'
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

{ #category : #'as yet unclassified' }
BoxGenerator >> add: aPercentage of: aBoxType [
	| indice |
	indice := 1.
	[(indice <= (size *aPercentage)) & (boxCol size < size)] whileTrue:[
			boxCol add: aBoxType new.
			indice := indice +1.].
	boxCol := boxCol shuffled.
	^boxCol.
		 
]

{ #category : #initalize }
BoxGenerator >> completeBoard [
	(boxCol size < size)
		ifTrue: [ (boxCol size) to: (size) do: [:emptyBox | boxCol add: (NoEffectBox new) ].	].
]

{ #category : #initalize }
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
	boxCol := OrderedCollection new.
	self createBoardFor: boxTypes with: probabilities.
	self completeBoard.
	^ boxCol
]
