Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'mySize'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withSize: aSize [
	(aSize < 1 ) ifTrue: [ Error signal: 'Un tablero no puede tener menos de 1 casillero.' ].
	^self new initializeWithSize: aSize.
]

{ #category : #'as yet unclassified' }
Board >> initialize [
	mySize :=0.
]

{ #category : #'as yet unclassified' }
Board >> initializeWithSize: aSize [
	mySize :=aSize.
]

{ #category : #'as yet unclassified' }
Board >> sizeOfBoard [
	^mySize.
]
