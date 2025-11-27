Class {
	#name : 'CMHooksHandler',
	#superclass : 'Object',
	#instVars : [
		'beforeHooks',
		'afterHooks'
	],
	#category : 'Cormas-Core-Kernel',
	#package : 'Cormas-Core',
	#tag : 'Kernel'
}

{ #category : 'api' }
CMHooksHandler >> addAfterHook: aBlock [

	afterHooks add: aBlock
]

{ #category : 'api' }
CMHooksHandler >> addBeforeHook: aBlock [

	beforeHooks add: aBlock
]

{ #category : 'api' }
CMHooksHandler >> afterHooks [

	afterHooks do: #value
]

{ #category : 'api' }
CMHooksHandler >> beforeHooks [

	beforeHooks do: #value
]

{ #category : 'initialization' }
CMHooksHandler >> initialize [

	super initialize.
	beforeHooks := OrderedCollection new.
	afterHooks := OrderedCollection new
]
