Class {
	#name : #NoEffectBox,
	#superclass : #SingleVictimBox,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
NoEffectBox >> affect: aPlayer and: aBoard [
	^[:a | Transcript show: 'No hubo efecto'.].
]
