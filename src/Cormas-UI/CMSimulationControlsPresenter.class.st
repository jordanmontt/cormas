Class {
	#name : 'CMSimulationControlsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'translator',
		'runButton',
		'stepButton',
		'speedDropList',
		'displayEveryNumberPresenter',
		'isFirstTimeExecuting'
	],
	#category : 'Cormas-UI',
	#package : 'Cormas-UI'
}

{ #category : 'examples' }
CMSimulationControlsPresenter class >> example [
	<example>
	
	(self forTranslator: CMEnglishTranslator new) open
]

{ #category : 'as yet unclassified' }
CMSimulationControlsPresenter class >> forTranslator: aTranslator [

	^ self on: aTranslator
]

{ #category : 'as yet unclassified' }
CMSimulationControlsPresenter >> beInPauseMode [

	self initializeRunButtonWithRunAction.
	stepButton enabled: true
]

{ #category : 'as yet unclassified' }
CMSimulationControlsPresenter >> beInRunningMode [

	self initializeRunButtonWithPauseAction.
	stepButton enabled: false
]

{ #category : 'initialization' }
CMSimulationControlsPresenter >> connectPresenters [

	stepButton action: [ owner stepSimulation ].

	self initializeRunButtonWithRunAction
]

{ #category : 'layout' }
CMSimulationControlsPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		  spacing: 5;
		  add: (SpBoxLayout newTopToBottom
				   spacing: 3;
				   add: translator tStepButtonLabel expand: false;
				   add: stepButton expand: false;
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newTopToBottom
				   spacing: 3;
				   add: translator tRun expand: false;
				   add: runButton expand: false;
				   yourself)
		  expand: false;
		  add: SpNullPresenter new;
		  add: (SpBoxLayout newTopToBottom
				   spacing: 3;
				   add: translator tSpeedLabel expand: false;
				   add: speedDropList expand: false;
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newTopToBottom
				   spacing: 3;
				   add: translator tDisplayEveryLabel expand: false;
				   add: displayEveryNumberPresenter expand: false;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : 'accessing' }
CMSimulationControlsPresenter >> displayEvery [
	
	^ displayEveryNumberPresenter number
]

{ #category : 'initialization' }
CMSimulationControlsPresenter >> initialize [

	super initialize.
	isFirstTimeExecuting := true
]

{ #category : 'initialization' }
CMSimulationControlsPresenter >> initializePresenters [

	runButton := self newButton
		             help: translator tRunButtonHelp;
		             yourself.

	stepButton := self newButton
		              icon: CMIcons stepIcon;
		              help: translator tStepButtonHelp;
		              yourself.

	speedDropList := self newDropList
		                 help: translator tSpeedHelp;
		                 items: self speedDropListItems;
		                 selectItem: translator tSpeedNormal;
		                 yourself.

	displayEveryNumberPresenter := self newNumberInput
		                beInteger;
		                minimum: 1;
		                number: 1;
		                yourself.

	self beInPauseMode
]

{ #category : 'as yet unclassified' }
CMSimulationControlsPresenter >> initializeRunButtonWithPauseAction [

	runButton
		icon: CMIcons pauseIcon;
		action: [ owner shouldPause: true ]
]

{ #category : 'as yet unclassified' }
CMSimulationControlsPresenter >> initializeRunButtonWithRunAction [

	runButton
		icon: CMIcons runIcon;
		action: [
				isFirstTimeExecuting
					ifTrue: [
							owner runSimulationUntilEnd.
							isFirstTimeExecuting := false ]
					ifFalse: [ owner shouldPause: false ] ]
]

{ #category : 'accessing - model' }
CMSimulationControlsPresenter >> setModelBeforeInitialization: aTranslator [

	translator := aTranslator
]

{ #category : 'as yet unclassified' }
CMSimulationControlsPresenter >> speedDropListItems [

	^ {
		  translator tSpeed10xSlower.
		  translator tSpeed5xSlower.
		  translator tSpeed2xSlower.
		  translator tSpeedNormal.
		  translator tSpeed2xFaster.
		  translator tSpeed5xFaster.
		  translator tSpeed10xFaster }
]

{ #category : 'as yet unclassified' }
CMSimulationControlsPresenter >> speedInMilliseconds [

	| normalSpeed mapping |
	normalSpeed := 200.

	mapping := {
		translator tSpeed10xSlower -> (normalSpeed * 10) .
		translator tSpeed5xSlower -> (normalSpeed * 5) .
		translator tSpeed2xSlower -> (normalSpeed * 2) .
		translator tSpeedNormal -> normalSpeed .
		translator tSpeed2xFaster -> (normalSpeed / 2) .
		translator tSpeed5xFaster -> (normalSpeed / 5) .
		translator tSpeed10xFaster -> (normalSpeed / 10)
	} asDictionary.
	
	^ mapping at: speedDropList selectedItem
]
