Class {
	#name : #SpeedUpCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedUpCard >> applyEffectFrom: aCardManager [ 
	^1.
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> cancelUsing: cancelationCard by:player andTell: cardManager [
	
	cardManager cancellateTarget: self using: cancelationCard from: player.
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> triggerEffectOn: target from: cardManager by: player [

	cardManager validatePermanentCard: self of: player. 
	cardManager affect:target with: self of: player.
]
