Class {
	#name : 'CMStopConditionPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'translator',
		'cormasModelClass',
		'hasFinalStepCheckbox',
		'finalStepLabel',
		'choice',
		'finalStepInput',
		'dummyTextInput',
		'stopConditionDropList',
		'onChangedBlock'
	],
	#category : 'Cormas-UI',
	#package : 'Cormas-UI'
}

{ #category : 'examples' }
CMStopConditionPresenter class >> example [
	<example>
	(self on: { CMMockModel . CMEnglishTranslator new}) open
]

{ #category : 'as yet unclassified' }
CMStopConditionPresenter >> activateFinalStep [

	finalStepLabel enable.
	choice updatePresenter.
	
	finalStepInput number > 0 ifFalse: [ 
		finalStepInput number: CMSimulation defaultFinalTimeStep ]
]

{ #category : 'compiling' }
CMStopConditionPresenter >> compileBlock: aSourceCode [

	"Black magic"
	^ Smalltalk compiler
		environment: self class environment;
		source: aSourceCode;
		evaluate
]

{ #category : 'accessing' }
CMStopConditionPresenter >> condition [
	"Note: we want to minimize the complexity of the returned block because it will be evaluated after each simulation step"

	"Case 1: Run simulation endlessly until paused"
	(hasFinalStepCheckbox state not and: [ stopConditionDropList isPlaceholderSelected ]) ifTrue: [ 
		^ [ :model | false ] ].
	
	"Case 2: Combine both stop criteria"
	(hasFinalStepCheckbox state and: [ stopConditionDropList isPlaceholderSelected not ]) ifTrue: [ 
		^ self compileBlock: ('[ :model |
			model currentTimeStep >= ', finalStepInput number asString, ' or: [
				model ', stopConditionDropList selectedItem, ' ] ]') ].
	
	"Case 3: Stop after a given number of steps"
	hasFinalStepCheckbox state ifTrue: [ 
		^ self compileBlock: ('[ :model | model currentTimeStep >= ', finalStepInput number asString, ' ]') ].
	
	"Case 4: Stop when a selected boolean method returns true"
	stopConditionDropList isPlaceholderSelected ifFalse: [ 
		^ self compileBlock: ('[ :model | model ', stopConditionDropList selectedItem, ' ]') ].
	
	self error: 'This should never happen'
]

{ #category : 'initialization' }
CMStopConditionPresenter >> connectPresenters [

	onChangedBlock := [ :conditionBlock | "do nothing" ].

	hasFinalStepCheckbox
		whenActivatedDo: [ self activateFinalStep ];
		whenDeactivatedDo: [ self deactivateFinalStep ];
		whenChangedDo: [ onChangedBlock value: self condition ].
		
	finalStepInput whenNumberChangedDo: [ onChangedBlock value: self condition ].
	stopConditionDropList whenSelectionChangedDo: [ onChangedBlock value: self condition ]
	
]

{ #category : 'as yet unclassified' }
CMStopConditionPresenter >> deactivateFinalStep [

	finalStepLabel disable.
	choice updatePresenter
]

{ #category : 'layout' }
CMStopConditionPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		borderWidth: 5;
		spacing: 10;
		add: hasFinalStepCheckbox expand: false;
		add: (SpGridLayout new
			borderWidth: 0;
			beColumnNotHomogeneous;
			column: 2 expand: true;
			build: [ :builder | builder
				add: finalStepLabel;
				add: choice;
				nextRow ]) expand: false;
		add: 'or when' expand: false;
		add: stopConditionDropList expand: false;
		yourself
]

{ #category : 'examples' }
CMStopConditionPresenter >> example [
	<script: 'self example'>
]

{ #category : 'initialization' }
CMStopConditionPresenter >> initializePresenters [

	hasFinalStepCheckbox := self newCheckBox
		label: 'Stop when final step is reached';
		yourself.
		
	finalStepLabel := self newLabel
		label: translator tFinalStep;
		yourself.
		
	finalStepInput := self newNumberInput.
		
	"a hack to replace number input because number inputs can't be disabled"
	dummyTextInput := self newTextInput
		text: '∞';
		beNotEditable;
		yourself.
		
	choice := self newPresenterSelector
		when: [ hasFinalStepCheckbox state ] show: [ finalStepInput ];
		when: [ hasFinalStepCheckbox state not ] show: [ dummyTextInput ];
		updatePresenter;
		yourself.
		
	self deactivateFinalStep.
	
	stopConditionDropList := (self instantiate: CMDropListWithPlaceholderPresenter)
		placeholder: 'boolean method'
		respondingTo: #value;
		items: cormasModelClass availableBooleanSelectors;
		display: [ :each | each value ];
		yourself
	
]

{ #category : 'accessing - model' }
CMStopConditionPresenter >> setModelBeforeInitialization: aCollection [

	cormasModelClass := aCollection first.
	translator := aCollection second
]

{ #category : 'announcing' }
CMStopConditionPresenter >> whenChangedDo: aBlock [
	"A one argument block accepting a stop condition block that is constructed by this UI"
	onChangedBlock := aBlock.
	
	"In case nothing is changed"
	onChangedBlock value: self condition
]
