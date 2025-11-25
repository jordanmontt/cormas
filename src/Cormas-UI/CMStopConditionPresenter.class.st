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
		'stopConditionDropList'
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

{ #category : 'initialization' }
CMStopConditionPresenter >> connectPresenters [

	hasFinalStepCheckbox
		whenActivatedDo: [ self activateFinalStep ];
		whenDeactivatedDo: [ self deactivateFinalStep ].
	
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
