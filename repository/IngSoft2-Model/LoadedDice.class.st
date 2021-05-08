Class {
	#name : #LoadedDice,
	#superclass : #Object,
	#instVars : [
		'index',
		'myTosses'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
LoadedDice class >> withTosses: someTosses [ 

	^self new initializeWithTheFollowingTosses: someTosses.
]

{ #category : #'as yet unclassified' }
LoadedDice >> index [
	^index.
]

{ #category : #'as yet unclassified' }
LoadedDice >> initialize [ 
	index:=0.
	myTosses := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
LoadedDice >> initializeWithTheFollowingTosses: someTosses [ 
	myTosses:= someTosses.
	index:=0.
]

{ #category : #'as yet unclassified' }
LoadedDice >> spin [
	 (index >= (myTosses size))
		ifTrue: [ index:=0 .].
	index := index +1.
	^(myTosses at: index).
]
