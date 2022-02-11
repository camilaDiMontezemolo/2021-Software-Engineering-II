Class {
	#name : #SpeedUpCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedUpCard >> applyEffectFrom: aCardManager [ 
	^1.
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> triggerEffectOn: target from: aCardManager by: aPlayer [
	aCardManager validatePermanentCard: self of: aPlayer. 
	aCardManager affect:target with: self of: aPlayer.
]
