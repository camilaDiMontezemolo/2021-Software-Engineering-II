Class {
	#name : #JailEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
JailEffect >> affect: positions triggeredOn: aPosition on: board withPreviousAdvance: distance [

	board addToImprisioned: aPosition player.
	self freedomConditionFor: aPosition on: board verifying: distance
]

{ #category : #'as yet unclassified' }
JailEffect >> freedomConditionFor: aPosition on: board verifying: distance [

	distance = board maximunToss
		ifTrue: [ 
			board removeFromImprisioned: aPosition player.
			board change: aPosition by: distance ]
		ifFalse: [].
]