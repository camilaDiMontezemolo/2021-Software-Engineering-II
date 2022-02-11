Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'tosses',
		'indice',
		'sides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LoadedDie class >> withTosses: someTosses andSides: sides [

	^self new initializeWithTheFollowingTosses: someTosses andSides: sides.
]

{ #category : #initalize }
LoadedDie >> initializeWithTheFollowingTosses: someTosses andSides: DieSides [
	tosses := OrderedCollection new.
	tosses:= someTosses.
	sides := DieSides.
	indice:=0.
]

{ #category : #'as yet unclassified' }
LoadedDie >> maxToss [
	^(sides)
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
