Class {
	#name : #MoveWithCancellationCard,
	#superclass : #Move,
	#instVars : [
		'affectedPlayer',
		'active',
		'affectedCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoveWithCancellationCard class >> of: player on: anotherCard [
	anotherCard instant
		ifTrue: [ Error signal: 'No se puede cancelar una carta instantanea.' ].
	(anotherCard active) 
	ifFalse: [ Error signal: 'No se puede cancelar una carta inactiva.' ].
	^ self new initializeWithPlayer: player andAffectedCard: anotherCard
]

{ #category : #initialization }
MoveWithCancellationCard >> initializeWithPlayer: player andAffectedCard: anotherCard [ 
	owner :=player.
	affectedCard :=anotherCard.
	active := (anotherCard isAnEmptyObject) not.
	instant :=true.
]
