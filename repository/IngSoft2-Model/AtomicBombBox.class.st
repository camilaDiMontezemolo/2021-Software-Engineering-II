Class {
	#name : #AtomicBombBox,
	#superclass : #MultVictimBox,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AtomicBombBox >> affect: somePlayers and: aBoard [
	somePlayers do: [:player | player setLocation: 0].
]
