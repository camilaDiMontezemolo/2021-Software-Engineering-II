Class {
	#name : #SpeedPlusCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedPlusCard >> triggerEffectOn: target from: cardManager by: player [
	cardManager validatePermanentCard: self of: player. 
	cardManager addSpeedUpToBoxOf: player.
]
