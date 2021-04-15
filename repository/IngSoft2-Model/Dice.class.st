Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'sides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Dice class >> withSides: numberOfSides [ 
	^self new initializeWithSides: numberOfSides.
]

{ #category : #initialize }
Dice >> initialize [ 
	sides:= 0.
]

{ #category : #initialize }
Dice >> initializeWithSides: aNumberOfSides [ 
	"aNumberOfSides < 1 ifTrue: [ ^(self error: 'No existen los dados de 0 lados') ]."
	aNumberOfSides < 1 ifTrue: [ ^(Error) ].
	sides:= aNumberOfSides.
]

{ #category : #'as yet unclassified' }
Dice >> sides [
	^sides.
]

{ #category : #'as yet unclassified' }
Dice >> spin [
	^(sides atRandom).
]
