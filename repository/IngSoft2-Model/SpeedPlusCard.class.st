Class {
	#name : #SpeedPlusCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedPlusCard >> cancelUsing: cancelationCard by:player andTell: cardManager [
	
	cardManager removeEffectBy: self using: cancelationCard by: player.
]

{ #category : #'as yet unclassified' }
SpeedPlusCard >> triggerEffectOn: target from: cardManager by: player [

	cardManager validatePermanentCard: self of: player.
	cardManager addSpeedUpToBoxOf: player using: self
]
