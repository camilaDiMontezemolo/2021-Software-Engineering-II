Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Card class >> of: player on: affectedPlayer [
self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
Card >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [
self subclassResponsibility
]
