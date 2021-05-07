Class {
	#name : #SpeedupBox,
	#superclass : #SingleVictimBox,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedupBox >> affect: aPlayer and: aBoard [
	(aPlayer location + 4  < (aBoard sizeOfBoard))
	ifTrue: [
		aPlayer setLocation:(aPlayer location + 4).
	]
	ifFalse: [ 
		aPlayer setLocation: (4 - (aBoard sizeOfBoard - aPlayer location)).
		aPlayer increaseLaps.
	].
]
