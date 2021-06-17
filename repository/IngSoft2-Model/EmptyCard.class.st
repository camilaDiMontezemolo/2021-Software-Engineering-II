Class {
	#name : #EmptyCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
EmptyCard >> active [
	^true
]

{ #category : #'as yet unclassified' }
EmptyCard >> instant [
	^false
]

{ #category : #'as yet unclassified' }
EmptyCard >> isAnEmptyCard [
	^true.
]
