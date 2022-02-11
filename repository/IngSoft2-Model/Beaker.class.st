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
]

{ #category : #'as yet unclassified' }
Beaker >> maxToss [
	|toss maxim|
	toss :=0.
	maxim := 0.
	dice do: [ :die | maxim:= maxim+( die maxToss) ].
	^(maxim)
	
	
]

{ #category : #'as yet unclassified' }
Beaker >> size [
	^(dice size)
]

{ #category : #'as yet unclassified' }
Beaker >> spin [
	|distance|
	distance := 0.
	dice do: [ :die | distance := distance + die spin ].
	^distance.
]
