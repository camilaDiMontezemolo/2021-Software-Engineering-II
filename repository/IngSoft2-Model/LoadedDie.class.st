Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'tosses',
		'index',
		'sides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LoadedDie class >> validateSides: numberOfSides [
	numberOfSides < 3
		ifTrue: [ Error signal: 'Un dado no puede tener menos de 3 cara(s).' ]
]

{ #category : #'instance creation' }
LoadedDie class >> withTosses: someTosses andSides: dieSides [

	self validateSides: dieSides.	
	^ self new initializeWithTheFollowingTosses: someTosses andSides: dieSides
]

{ #category : #initalize }
LoadedDie >> initializeWithTheFollowingTosses: dieTosses andSides: dieSides [ 
	tosses := OrderedCollection new.
	tosses:= dieTosses.
	sides := dieSides.
	index := 0.
]

{ #category : #'as yet unclassified' }
LoadedDie >> maxToss [
	^sides
]

{ #category : #'as yet unclassified' }
LoadedDie >> size [
	^1
]

{ #category : #'as yet unclassified' }
LoadedDie >> spin [
	 (index >= (tosses size))
		ifTrue: [ index:=0 .].
	index := index +1.
	^(tosses at: index).
]
