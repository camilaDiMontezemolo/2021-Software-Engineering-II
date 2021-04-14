Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'mySize',
		'myPlayers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withSize: aSize [
	^self new initializeWithSize: aSize
]

{ #category : #'instance creation' }
Board class >> withSize: aSize andPlayers: somePlayers [
	^self new initializeWithSize: aSize andPlayers: somePlayers.
]

{ #category : #initialize }
Board >> initialize [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
	mySize :=0.
	myPlayers := OrderedCollection new
]

{ #category : #initialize }
Board >> initializeWithSize: aSize [
	mySize:=aSize.
]

{ #category : #initialize }
Board >> initializeWithSize: aSize andPlayers: somePlayers [
	mySize:=aSize.
	myPlayers:=somePlayers.
]

{ #category : #'as yet unclassified' }
Board >> isFinished [
	^myPlayers anySatisfy: [ :player | (player location) >= mySize].
]

{ #category : #'as yet unclassified' }
Board >> players [
	^myPlayers.
]

{ #category : #'as yet unclassified' }
Board >> showPositions [
	myPlayers sort: [:a :c | (a location) > (c location)].
	"myPlayers do: [ :player | Transcript show: 'Name: ', (player name), 'Location: ', (player location); cr]."
	^myPlayers.
	
]

{ #category : #'as yet unclassified' }
Board >> sizeOfBoard [
	^mySize.
]
