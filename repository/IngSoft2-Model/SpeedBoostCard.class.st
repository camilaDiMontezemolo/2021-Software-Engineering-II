Class {
	#name : #SpeedBoostCard,
	#superclass : #Instantaneous,
	#category : #'IngSoft2-Model'
}

{ #category : #'apply effects' }
SpeedBoostCard >> triggerInstantaneousEffect: affectedCard  from: aCardManager [
	aCardManager speedBoostValidationFor: affectedCard.
	aCardManager speedBoostCard: affectedCard.
	aCardManager lastCardUsed: self.
]
