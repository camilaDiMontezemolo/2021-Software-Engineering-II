Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CancellationCard >> triggerInstantaneousEffect: affectedCard  from: aCardManager [
	aCardManager cancellateCard: affectedCard.
	aCardManager lastCardUsed: self.
]
