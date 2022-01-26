Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'tosses',
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
	tosses := OrderedCollection new.
	tosses:= someTosses.
	indice:=0.
]

{ #category : #'as yet unclassified' }
LoadedDie >> size [
	^1
]

{ #category : #'as yet unclassified' }
LoadedDie >> spin [
	 (indice >= (tosses size))
		ifTrue: [ indice:=0 .].
	indice := indice +1.
	^(tosses at: indice).
]
