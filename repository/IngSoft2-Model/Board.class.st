Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'mySize'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withSize: aSize [ 
	^self new initializeUsing: aSize.
]

{ #category : #initialize }
Board >> initialize [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
	mySize :=0.
]

{ #category : #initialize }
Board >> initializeUsing: aSize [
	mySize:=aSize.
]

{ #category : #'as yet unclassified' }
Board >> sizeOfBoard [
	^mySize.
]
