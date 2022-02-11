Class {
	#name : #LibertyCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
LibertyCard >> triggerEffectOn: target from: aCardManager by: aPlayer [
	aCardManager liberatePlayer: target.
]
