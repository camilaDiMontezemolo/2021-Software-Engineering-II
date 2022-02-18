Class {
	#name : #SpeedPlusCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #cardEffect }
SpeedPlusCard >> cancelUsing: cancelationCard by:player andTell: cardManager [
	
	cardManager removeEffectBy: self using: cancelationCard by: player.
]

{ #category : #cardEffect }
SpeedPlusCard >> triggerEffectOn: target from: cardManager by: player [

	cardManager validatePermanentCard: self of: player.
	cardManager addEffect: SpeedupEffect new ToBoxOf: player using: self.
]
