Class {
	#name : #SpeedBoostCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedBoostCard >> triggerInstantaneousEffect: affectedCard  from: aCardManager [
	aCardManager speedBoostCard: affectedCard.
	aCardManager lastCardUsed: self.
]
