Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'sides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Dice class >> validateSides: numberOfSides [
	numberOfSides < 3
		ifTrue: [ Error signal: 'Un dado no puede tener menos de 3 cara(s).' ]
]

{ #category : #'instance creation' }
Dice class >> withSides: numberOfSides [
	self validateSides: numberOfSides.
	^ self new initializeWithSides: numberOfSides
]

{ #category : #initialize }
Dice >> initializeWithSides: aNumberOfSides [ 
	sides:= aNumberOfSides.
]

{ #category : #'as yet unclassified' }
Dice >> spin [
	^(sides atRandom).
]
