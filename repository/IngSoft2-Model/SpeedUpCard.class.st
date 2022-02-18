Class {
	#name : #SpeedUpCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #cardEffect }
SpeedUpCard >> applyEffectFrom: aCardManager [ 
	^1.
]

{ #category : #cardEffect }
SpeedUpCard >> cancelUsing: cancelationCard by:player andTell: cardManager [
	
	cardManager cancellateTarget: self using: cancelationCard from: player.
]

{ #category : #cardEffect }
SpeedUpCard >> triggerEffectOn: target from: cardManager by: player [

	cardManager validatePermanentCard: self of: player. 
	cardManager affect:target with: self of: player.
]
