Class {
	#name : #Beaker,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Beaker class >> with: dice [
	^self new intializeWithDice: dice
]

{ #category : #initialize }
Beaker >> intializeWithDice: gameDice [
	dice := gameDice.
	(dice isEmpty)
	ifTrue: [ Error signal: 'No se puede implementar un cubilete vacio' ]
]

{ #category : #toss }
Beaker >> maxToss [
	|max|
	max := 0.
	dice do: [ :die | max := max + die maxToss  ].
	^max.
]

{ #category : #accessing }
Beaker >> size [
	^(dice size)
]

{ #category : #toss }
Beaker >> spin [
	|distance|
	distance := 0.
	dice do: [ :die | distance := distance + die spin ].
	^distance.
]
