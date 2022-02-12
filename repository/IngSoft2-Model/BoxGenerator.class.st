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
BoxGenerator class >> give: aSize [
	^ self new initializeWithSize: aSize
]

{ #category : #'as yet unclassified' }
BoxGenerator >> add: aPercentage of: aBoxType [
	| indice |
	indice := 1.
	[(indice <= (size *aPercentage)) & (boxCol size < size)] whileTrue:[
			boxCol add: aBoxType new.
			indice := indice +1.].
	boxCol := boxCol shuffled.
	self validatePorcenge: aPercentage.
	^boxCol.
		 
]

{ #category : #'as yet unclassified' }
BoxGenerator >> boxes [
	^boxCol.
		
]

{ #category : #initalize }
BoxGenerator >> initializeWithSize: aSize [
	size := (aSize-1).
	boxCol := OrderedCollection new.
	percentages := 0.

]

{ #category : #'as yet unclassified' }
BoxGenerator >> percentage [
	^percentages 
]

{ #category : #'as yet unclassified' }
BoxGenerator >> validatePorcenge: aPercentage [
	percentages := percentages + aPercentage.
	(percentages>1)
	ifTrue: [ Error signal: 'Las suma de probabilidades no puede ser mayor a 1.' ].
	(percentages=1)
	ifTrue:[ (boxCol size < size)
		ifTrue: [ 
			(boxCol size) to: (size) do: [:emptyBox | boxCol add: (NoEffectBox new) ].
		].]
]
