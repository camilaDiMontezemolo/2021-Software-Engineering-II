Class {
	#name : #RepeatCard,
	#superclass : #Instantaneous,
	#category : #'IngSoft2-Model'
}

{ #category : #'apply effects' }
RepeatCard >> triggerInstantaneousEffect: affectedPlayer  from: aCardManager [
	aCardManager lastCardUsed: self.
	aCardManager lastTypeOfBoxForPlayer: affectedPlayer.
]
