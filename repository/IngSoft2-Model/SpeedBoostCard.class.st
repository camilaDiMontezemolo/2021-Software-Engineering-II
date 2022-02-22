Class {
	#name : #SpeedBoostCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'apply effects' }
SpeedBoostCard >> triggerInstantaneousEffect: affectedCard  from: aCardManager [
	aCardManager speedBoostCard: affectedCard.
	aCardManager lastCardUsed: self.
]
