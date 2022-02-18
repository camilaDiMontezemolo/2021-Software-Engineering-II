Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #cardEffect }
AccelerationCard >> applyEffectFrom: cardManager [ 
	^1.
]

{ #category : #cardEffect }
AccelerationCard >> cancelUsing: cancelationCard by:player andTell: cardManager [
	
	cardManager cancellateTarget: self using: cancelationCard from: player.
]

{ #category : #cardEffect }
AccelerationCard >> triggerEffectOn: target from: cardManager by: player [

	cardManager validateAllPlayersIn: target.
	cardManager validatePermanentCard: self of: player. 
	cardManager affect:target with: self of: player.
]
