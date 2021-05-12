Class {
	#name : #LoadedDice,
	#superclass : #Object,
	#instVars : [
		'myTosses',
		'indice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
LoadedDice class >> withTosses: someTosses [ 

	^self new initializeWithTheFollowingTosses: someTosses.
]

{ #category : #'as yet unclassified' }
LoadedDice >> indice [
	^indice.
]

{ #category : #'as yet unclassified' }
LoadedDice >> initialize [ 
	indice:=0.
	myTosses := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
LoadedDice >> initializeWithTheFollowingTosses: someTosses [ 
	myTosses:= someTosses.
	indice:=0.
]

{ #category : #'as yet unclassified' }
LoadedDice >> spin [
	 (indice >= (myTosses size))
		ifTrue: [ indice:=0 .].
	indice := indice +1.
	^(myTosses at: indice).
]
