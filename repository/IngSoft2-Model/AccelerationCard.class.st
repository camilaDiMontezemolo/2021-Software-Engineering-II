Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AccelerationCard >> applyEffectFrom: aCardManager [ 
	^1.
]

{ #category : #'as yet unclassified' }
AccelerationCard >> triggerEffectOn: target from: aCardManager by: aPlayer [
	aCardManager validateAllPlayersIn: target.
	aCardManager validatePermanentCard: self of: aPlayer. 
	aCardManager affect:target with: self of: aPlayer.
]
