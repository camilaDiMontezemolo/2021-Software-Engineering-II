Class {
	#name : #MoonWalkBox,
	#superclass : #MultVictimBox,
	#instVars : [
		'n'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalkBox >> affect: somePlayers and: aBoard [
	somePlayers do: [ :player | player setLocation: (player location - n) ].
]

{ #category : #'as yet unclassified' }
MoonWalkBox >> initialize [
	n:= 5 atRandom.
]
