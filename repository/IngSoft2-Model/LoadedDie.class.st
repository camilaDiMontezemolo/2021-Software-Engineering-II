Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'tosses',
		'index'
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
	index:=0.
]

{ #category : #'as yet unclassified' }
LoadedDie >> size [
	^1
]

{ #category : #'as yet unclassified' }
LoadedDie >> spin [
	(index >= tosses size) ifTrue: [ index:=0 .].
	index := index +1.
	^tosses at: index.
]
