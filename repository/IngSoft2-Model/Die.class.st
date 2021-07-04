Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'sides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Die class >> validateSides: numberOfSides [
	numberOfSides < 3
		ifTrue: [ Error signal: 'Un dado no puede tener menos de 3 cara(s).' ]
]

{ #category : #'instance creation' }
Die class >> withSides: numberOfSides [
	self validateSides: numberOfSides.
	^ self new initializeWithSides: numberOfSides
]

{ #category : #initialize }
Die >> initializeWithSides: aNumberOfSides [ 
	sides:= aNumberOfSides.
]

{ #category : #'as yet unclassified' }
Die >> spin [
	^(sides atRandom).
]
