Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CancellationCard >> triggerEffectOn: target from: cardManager by: player [

	cardManager validateinstant: self of: player.
	target cancelUsing: self by:player andTell: cardManager.  
	cardManager lastCardUsed: self.
]
