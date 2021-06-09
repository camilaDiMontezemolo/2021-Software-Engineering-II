Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#instVars : [
		'owner',
		'affectedPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
OverloadCard class >> of: player [
	^self new initializeWithPlayer: player.
]

{ #category : #'as yet unclassified' }
OverloadCard >> affected [
	^affectedPlayer.
]

{ #category : #'as yet unclassified' }
OverloadCard >> applyEffect [
	^-2.
]

{ #category : #'as yet unclassified' }
OverloadCard >> applyEffectTo: aPlayer [
	affectedPlayer:= aPlayer.
]

{ #category : #'as yet unclassified' }
OverloadCard >> applyOver: aPlayer [ 
	affectedPlayer:= aPlayer.
]

{ #category : #'as yet unclassified' }
OverloadCard >> belongsTo: player [
	owner := player.
]

{ #category : #initialize }
OverloadCard >> initializeWithPlayer: player [
	owner :=player.
	affectedPlayer :=player.
]
