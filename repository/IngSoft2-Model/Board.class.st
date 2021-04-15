Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'mySize',
		'myPlayers',
		'myDie'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withSize: aSize andPlayers: somePlayers andDie: someDie [.
	^self new initializeWithSize: aSize andPlayers: somePlayers andDie: someDie.
]

{ #category : #initialize }
Board >> initialize [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
	mySize :=0.
	myPlayers := OrderedCollection new.
	myDie:= OrderedCollection new.
]

{ #category : #initialize }
Board >> initializeWithSize: aSize andPlayers: somePlayers andDie: someDie [
	mySize:=aSize.
	myPlayers:=somePlayers.
	myDie:=someDie.
]

{ #category : #'as yet unclassified' }
Board >> isFinished [
	^myPlayers anySatisfy: [ :player | (player location) >= mySize].
]

{ #category : #'as yet unclassified' }
Board >> play [
	myPlayers do: [ :player |
		(self isFinished) 
		ifFalse: [
			 player tosses: myDie.
			].
		].
	(self isFinished )
	ifFalse: [^(self play)]
	ifTrue:[^(self showPositions)].
]

{ #category : #'as yet unclassified' }
Board >> players [
	^myPlayers.
]

{ #category : #'as yet unclassified' }
Board >> showPositions [
	myPlayers sort: [:a :c | (a location) > (c location)].
	myPlayers do: [ :player |
		 Transcript show: 'Position: ' , ((myPlayers indexOf: player) printString), ' Name: ', (player name), ' Location: ', ((player location) printString); cr].
	^myPlayers.
]

{ #category : #'as yet unclassified' }
Board >> sizeOfBoard [
	^mySize.
]
