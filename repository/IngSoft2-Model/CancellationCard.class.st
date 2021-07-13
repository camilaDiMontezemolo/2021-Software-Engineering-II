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
	active := (anotherCard isAnEmptyObject) not.
	instant :=true.
]

{ #category : #'as yet unclassified' }
CancellationCard >> instant [
	^instant.
]

{ #category : #'as yet unclassified' }
CancellationCard >> owner [
	^owner.
]
