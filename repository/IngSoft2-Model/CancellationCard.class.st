Class {
	#name : #CancellationCard,
	#superclass : #Card,
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
CancellationCard >> cancellateCard: affectedCard  from: aCardManager [
	aCardManager lastCardUsed:self.
	aCardManager cancellateCard: affectedCard.
]
