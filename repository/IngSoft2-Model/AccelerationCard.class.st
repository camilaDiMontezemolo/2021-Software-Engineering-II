Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AccelerationCard >> applyEffectFrom: cardManager [ 
	^1.
]

{ #category : #'as yet unclassified' }
AccelerationCard >> cancelUsing: cancelationCard by:player andTell: cardManager [
	
	cardManager cancellateTarget: self using: cancelationCard from: player.
]

{ #category : #'as yet unclassified' }
AccelerationCard >> triggerEffectOn: target from: cardManager by: player [

	cardManager validateAllPlayersIn: target.
	cardManager validatePermanentCard: self of: player. 
	cardManager affect:target with: self of: player.
]
