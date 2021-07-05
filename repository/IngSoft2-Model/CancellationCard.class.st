Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#instVars : [
		'owner',
		'affectedPlayer',
		'active',
		'instant',
		'affectedCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CancellationCard class >> of: player on: anotherCard [
	anotherCard instant
		ifTrue: [ Error signal: 'No se puede cancelar una carta instantanea.' ].
	(anotherCard active) 
	ifFalse: [ Error signal: 'No se puede cancelar una carta inactiva.' ].
	^ self new initializeWithPlayer: player andAffectedCard: anotherCard
]

{ #category : #'as yet unclassified' }
CancellationCard >> active [
	^active
]

{ #category : #'as yet unclassified' }
CancellationCard >> affectedCard [
	^affectedCard
]

{ #category : #'as yet unclassified' }
CancellationCard >> applyEffectFrom: aDeck [ 
	(active) 
	ifTrue:[aDeck lastCardUsed:self.
		aDeck removeCard: affectedCard.]
	ifFalse:[^0].
]

{ #category : #initialize }
CancellationCard >> initializeWithPlayer: player andAffectedCard: anotherCard [ 
	owner :=player.
	affectedCard :=anotherCard.
	active := (anotherCard isAnEmptyCard) not.
	instant :=true.
]

{ #category : #'as yet unclassified' }
CancellationCard >> instant [
	^instant.
]

{ #category : #testing }
CancellationCard >> isAssignedTo: onePlayer [
	owner :=onePlayer.
	active := (affectedCard isAnEmptyCard) not.
	instant :=true.
]

{ #category : #'as yet unclassified' }
CancellationCard >> owner [
	^owner.
]

{ #category : #'as yet unclassified' }
CancellationCard >> usedOn: player [
	^(player = affectedCard)
]
