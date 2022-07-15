Class {
	#name : #CancellationCard,
	#superclass : #Instantaneous,
	#category : #'IngSoft2-Model'
}

{ #category : #'apply effects' }
CancellationCard >> triggerInstantaneousEffect: affectedCard  from: aCardManager [
	aCardManager cancellateCard: affectedCard.
	aCardManager lastCardUsed: self.
]
