Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #cardEffect }
OverloadCard >> applyEffectFrom: aCardManager [ 
	^-2.
]

{ #category : #cardEffect }
OverloadCard >> cancelUsing: cancelationCard by:player andTell: cardManager [
	
	cardManager cancellateTarget: self using: cancelationCard from: player.
]

{ #category : #cardEffect }
OverloadCard >> triggerEffectOn: target from: cardManager by: player [

	cardManager validatePermanentCard: self of: player. 
	cardManager affect:target with: self of: player.
]
