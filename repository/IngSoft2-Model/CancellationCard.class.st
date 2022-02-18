Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #cardEffect }
CancellationCard >> triggerEffectOn: target from: cardManager by: player [

	cardManager validateinstant: self of: player.
	cardManager validateCancellationFor: target.
	target cancelUsing: self by:player andTell: cardManager.  
	cardManager lastCardUsed: self.
]
