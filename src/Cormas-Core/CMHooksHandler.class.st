Class {
	#name : 'CMHooksHandler',
	#superclass : 'Object',
	#instVars : [
		'afterHooks',
		'beforeHooks'
	],
	#category : 'Cormas-Core',
	#package : 'Cormas-Core'
}

{ #category : 'adding' }
CMHooksHandler >> addAfterHook: aBlock [

	afterHooks add: aBlock
]

{ #category : 'adding' }
CMHooksHandler >> addBeforeHook: aBlock [

	beforeHooks add: aBlock
]

{ #category : 'adding' }
CMHooksHandler >> executeAfterHooks [

	afterHooks do: #value
]

{ #category : 'adding' }
CMHooksHandler >> executeBeforeHooks [

	beforeHooks do: #value
]

{ #category : 'initialization' }
CMHooksHandler >> initialize [

	super initialize.

	beforeHooks := OrderedCollection new.
	afterHooks := OrderedCollection new
]
