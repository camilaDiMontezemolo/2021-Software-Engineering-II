Class {
	#name : #Move,
	#superclass : #Object,
	#instVars : [
		'instant',
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Move class >> of: player on: affectedPlayer [
self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
Move >> applyEffectFrom: aDeck [ 
self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Move >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [
self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Move >> instant [
	^instant.
]

{ #category : #'as yet unclassified' }
Move >> owner [
	^owner.
]
