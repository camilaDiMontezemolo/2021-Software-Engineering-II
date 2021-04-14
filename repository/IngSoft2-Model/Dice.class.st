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
