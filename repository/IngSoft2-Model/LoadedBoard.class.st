Class {
	#name : #LoadedBoard,
	#superclass : #Object,
	#instVars : [
		'mySize',
		'myBoxes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
LoadedBoard class >> withBoxes: someBoxes [
	^self new initializeWithBoxes: someBoxes.
]

{ #category : #'as yet unclassified' }
LoadedBoard >> boxes [
	^myBoxes.
	
		
]

{ #category : #'as yet unclassified' }
LoadedBoard >> initialize [
	mySize :=0.
	myBoxes := OrderedCollection new.
	
		
]

{ #category : #'as yet unclassified' }
LoadedBoard >> initializeWithBoxes: someBoxes [
	myBoxes := someBoxes.
	myBoxes add: (NoEffectBox new).
	mySize := ( (myBoxes size)-1 )
	"Y el menos no se saca".
	
		
]

{ #category : #'as yet unclassified' }
LoadedBoard >> sizeOfBoard [
	^(mySize).
	
		
]
