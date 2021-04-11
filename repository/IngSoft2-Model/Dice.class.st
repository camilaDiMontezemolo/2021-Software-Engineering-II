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
	^self new initializeUsing: numberOfSides.
]

{ #category : #initialize }
Dice >> initialize [ 
	sides:= 0.
]

{ #category : #initialize }
Dice >> initializeUsing: aNumberOfSides [ 
	sides:= aNumberOfSides.
]

{ #category : #'as yet unclassified' }
Dice >> sides [
	^sides.
]
