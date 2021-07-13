Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'instant',
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Card class >> of: player on: affectedPlayer [
self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
Card >> applyEffectFrom: aDeck [ 
self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Card >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [
self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Card >> instant [
	^instant.
]

{ #category : #'as yet unclassified' }
Card >> owner [
	^owner.
]
