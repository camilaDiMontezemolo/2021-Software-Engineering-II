Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#instVars : [
		'affectedPlayer',
		'active',
		'affectedCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CancellationCard class >> of: player on: anotherCard [
	anotherCard instant
		ifTrue: [ Error signal: 'No se puede cancelar una carta instantanea.' ].
	(anotherCard active) 
	ifFalse: [ Error signal: 'No se puede cancelar una carta inactiva.' ].
	^ self new initializeWithPlayer: player andAffectedCard: anotherCard
]

{ #category : #'as yet unclassified' }
CancellationCard >> applyEffectFrom: aCardManager [ 
	aCardManager lastCardUsed:self.
	aCardManager removeCard: affectedCard.
]

{ #category : #initialize }
CancellationCard >> instant [ 
	^true.
]
