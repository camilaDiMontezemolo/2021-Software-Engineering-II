Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#instVars : [
		'owner',
		'active',
		'instant',
		'affectedCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CancellationCard class >> of: player on: anotherCard [
	^self new initializeWithPlayer: player andAffectedCard: anotherCard.
]

{ #category : #'as yet unclassified' }
CancellationCard >> affected [
	^affectedCard.
]

{ #category : #'as yet unclassified' }
CancellationCard >> applyEffectFrom: aDeck [ 
	(active) 
	ifTrue:[aDeck lastCardUsed:self.
		aDeck removeCard: affectedCard.
		"aDeck removeCard: self."]
	ifFalse:[^0].
]

{ #category : #initialize }
CancellationCard >> initializeWithPlayer: player andAffectedCard: anotherCard [ 
	owner :=player.
	affectedCard :=anotherCard.
	active := (affectedCard isNotNil).
	instant :=true.
]

{ #category : #initialize }
CancellationCard >> instant [
	^instant.
]

{ #category : #initialize }
CancellationCard >> owner [
	^owner.
]

{ #category : #'as yet unclassified' }
CancellationCard >> usedOn: player [
	^(player = affectedCard)
]
