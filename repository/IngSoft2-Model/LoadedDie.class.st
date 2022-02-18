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
LoadedDie class >> validateTosses: numberOfTosses AndCompatibilityWithSize: dieSize [
	numberOfTosses do: [ :toss | 
		(toss<=0) ifTrue:[Error signal: 'No se pueden usar tiradas iguales o menores a cero' ].
		(toss>dieSize) ifTrue: [Error signal: 'La tirada no puede ser mayor que el tamaño del dado']
	].
]

{ #category : #'instance creation' }
LoadedDie class >> withTosses: someTosses andSides: dieSides [

	self validateSides: dieSides.
	self validateTosses: someTosses AndCompatibilityWithSize: dieSides.
	^ self new
		  initializeWithTheFollowingTosses: someTosses
		  andSides: dieSides
]

{ #category : #initalize }
LoadedDie >> initializeWithTheFollowingTosses: dieTosses andSides: dieSides [ 
	tosses := OrderedCollection new.
	tosses:= dieTosses.
	sides := dieSides.
	index := 0.
]

{ #category : #toss }
LoadedDie >> maxToss [
	^sides
]

{ #category : #accessing }
LoadedDie >> size [
	^1
]

{ #category : #toss }
LoadedDie >> spin [
	 (index >= (tosses size))
		ifTrue: [ index:=0 .].
	index := index +1.
	^(tosses at: index).
]
