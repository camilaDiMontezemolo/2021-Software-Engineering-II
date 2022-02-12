Class {
	#name : #LibertyCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
LibertyCard >> triggerEffectOn: target from: cardManager by: player [
	cardManager lastCardUsed: self.
	cardManager liberatePlayer: target.
	
]
