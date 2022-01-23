Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'myTosses',
		'indice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LoadedDie class >> withTosses: someTosses [ 

	^self new initializeWithTheFollowingTosses: someTosses.
]

{ #category : #initalize }
LoadedDie >> initializeWithTheFollowingTosses: someTosses [ 
	myTosses := OrderedCollection new.
	myTosses:= someTosses.
	indice:=0.
]

{ #category : #'as yet unclassified' }
LoadedDie >> spin [
	 (indice >= (myTosses size))
		ifTrue: [ indice:=0 .].
	indice := indice +1.
	^(myTosses at: indice).
]
