Class {
	#name : 'CMSimulationProcessRunner',
	#superclass : 'Object',
	#instVars : [
		'simulationProcess',
		'stopCondition',
		'simulation',
		'simulationBlock'
	],
	#category : 'Cormas-Core-Kernel',
	#package : 'Cormas-Core',
	#tag : 'Kernel'
}

{ #category : 'api - type of simulation' }
CMSimulationProcessRunner >> beDefaultSimulation [

	simulationBlock := [
		[ stopCondition value: simulation cormasModel ] whileFalse: [
			simulation runStep ] ]
]

{ #category : 'api - type of simulation' }
CMSimulationProcessRunner >> beSimulationAfterEach: aNumberOfSteps do: aBlock [

	simulationBlock := [ 
		[ stopCondition value: simulation cormasModel ] whileFalse: [
			simulation runStep.
			simulation currentTimeStep % aNumberOfSteps = 0 ifTrue: [ aBlock value ] ] ]
]

{ #category : 'api - type of simulation' }
CMSimulationProcessRunner >> beSimulationAfterEachDo: aBlock [

	simulationBlock := [ 
		[ stopCondition value: simulation cormasModel ] whileFalse: [
			simulation runStep.
			aBlock value ] ]
]

{ #category : 'api - type of simulation' }
CMSimulationProcessRunner >> beSimulationWithStepDelay: milliseconds [

	simulationBlock := [
		[ stopCondition value: simulation cormasModel ] whileFalse: [
			simulation runStep.
			(Delay forMilliseconds: milliseconds) wait ] ]
]

{ #category : 'api - type of simulation' }
CMSimulationProcessRunner >> beSimulationWithStepDelay: milliseconds afterEach: aNumberOfSteps do: aBlock [

	simulationBlock := [
		[ stopCondition value: simulation cormasModel ] whileFalse: [
			simulation runStep.
			simulation currentTimeStep % aNumberOfSteps = 0 ifTrue: [ aBlock value ].
			(Delay forMilliseconds: milliseconds) wait ] ]
]

{ #category : 'api - type of simulation' }
CMSimulationProcessRunner >> beSimulationWithStepDelay: milliseconds afterEachDo: aBlock [

	simulationBlock := [
		[ stopCondition value: simulation cormasModel ] whileFalse: [
			simulation runStep.
			aBlock value.
			(Delay forMilliseconds: milliseconds) wait ] ]
]

{ #category : 'accessing' }
CMSimulationProcessRunner >> cormasSimulation: aCMSimulation [

	simulation := aCMSimulation
]

{ #category : 'api - running' }
CMSimulationProcessRunner >> isProcessConfigured [

	^ simulationProcess isNotNil
]

{ #category : 'api - running' }
CMSimulationProcessRunner >> isSimulationConfigured [

	^ simulationBlock isNotNil
]

{ #category : 'api - running' }
CMSimulationProcessRunner >> isSimulationRunning [

	simulationProcess ifNil: [ ^ false ].
	^ simulationProcess isActive
]

{ #category : 'api - processing' }
CMSimulationProcessRunner >> pause [

	simulationProcess suspend
]

{ #category : 'api - running' }
CMSimulationProcessRunner >> resume [

	simulationProcess resume
]

{ #category : 'api - processing' }
CMSimulationProcessRunner >> run [

	simulationBlock value
]

{ #category : 'api - running' }
CMSimulationProcessRunner >> runInBackground [

	simulationProcess := simulationBlock newProcess.
	simulationProcess resume
]

{ #category : 'accessing' }
CMSimulationProcessRunner >> stopCondition: aFullBlockClosure [

	stopCondition := aFullBlockClosure
]
