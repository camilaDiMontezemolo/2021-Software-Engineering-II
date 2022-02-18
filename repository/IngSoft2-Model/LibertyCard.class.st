Class {
	#name : #LibertyCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #cardEffect }
LibertyCard >> triggerEffectOn: target from: cardManager by: player [
	cardManager lastCardUsed: self.
	cardManager liberatePlayer: target.
	
]
