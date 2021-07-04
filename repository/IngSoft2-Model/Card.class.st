Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'owner',
		'affectedPlayer',
		'active',
		'instant',
		'affectedCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Card >> active [
	^active
]

{ #category : #accessing }
Card >> affectedPlayer [
	^affectedPlayer
]

{ #category : #accessing }
Card >> instant [
	^instant.
]

{ #category : #accessing }
Card >> owner [
	^owner.
]

{ #category : #accessing }
Card >> usedOn: player [ 
	^(affectedPlayer includes: player).
]
