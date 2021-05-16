Class {
	#name : #WormHoleBox,
	#superclass : #SingleVictimBox,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
WormHoleBox >> affect: aPlayer and: aBoard [
	(aPlayer location - 4  > 0)
	ifTrue: [
		aPlayer changeLocation:(aPlayer location - 4).
	]
	ifFalse: [ 
		aPlayer changeLocation: (aBoard sizeOfBoard - (aPlayer location - 4)).
		aPlayer changeLap.
	].
]
