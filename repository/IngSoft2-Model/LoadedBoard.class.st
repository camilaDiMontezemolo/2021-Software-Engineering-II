Class {
	#name : #LoadedBoard,
	#superclass : #Board,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
LoadedBoard class >> withBoxes: someBoxes [
	^self new initializeWithBoxes: someBoxes.
]

{ #category : #'as yet unclassified' }
LoadedBoard >> initialize [
	mySize :=0.
	myBoxes := OrderedCollection new.
	
		
]

{ #category : #'as yet unclassified' }
LoadedBoard >> initializeWithBoxes: someBoxes [
	myBoxes := someBoxes.
	mySize := (myBoxes size).
	
		
]
