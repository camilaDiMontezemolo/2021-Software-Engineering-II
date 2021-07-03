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
	numberOfSides < 3 ifTrue: [ Error signal: 'Un dado no puede tener menos de 3 cara(s).' ].
	^self new initializeWithSides: numberOfSides.
]

{ #category : #initialize }
Dice >> initializeWithSides: aNumberOfSides [ 
	sides:= aNumberOfSides.
]

{ #category : #'as yet unclassified' }
Dice >> spin [
	^(sides atRandom).
]
