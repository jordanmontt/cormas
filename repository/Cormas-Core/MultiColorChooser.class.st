Class {
	#name : #MultiColorChooser,
	#superclass : #Object,
	#instVars : [
		'listElements',
		'elementColorDict'
	],
	#category : 'Cormas-Core-Interface'
}

{ #category : #'interface specs' }
MultiColorChooser class >> windowSpec [
	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"
	
	<resource: #canvas>
	^#(FullSpec 
		#window: #(WindowSpec 
			#label: #(UserMessage 
				#key: #SelectColor 
				#defaultString: 'Select Color' 
				#catalogID: #labels) 
			#min: #(Point 545 236) 
			#max: #(Point 0 0) 
			#bounds: #(Rectangle 720 450 1265 686)) 
		#component: #(SpecCollection 
			#collection: #(#(CompositeSpecCollection 
				#collection: #() 
				#compositeSpec: #(CompositeSpec 
					#layout: #(Rectangle 470 151 536 175) 
					#name: #theActualColor 
					#colors: #(LookPreferences))) #(RegionSpec 
				#layout: #(Rectangle 470 151 536 175) 
				#lineWidth: 1) #(SliderSpec 
				#layout: #(Rectangle 162 9 183 175) 
				#model: #sliderModel 
				#orientation: #vertical) #(LabelSpec 
				#layout: #(Point 473 131) 
				#label: #(UserMessage 
					#key: #V 
					#defaultString: 'V' 
					#catalogID: #labels)) #(LabelSpec 
				#layout: #(Point 520 131) 
				#name: #hueLabel 
				#label: #(UserMessage 
					#key: #H 
					#defaultString: 'H' 
					#catalogID: #labels)) #(CompositeSpecCollection 
				#collection: #() 
				#compositeSpec: #(CompositeSpec 
					#layout: #(Rectangle 188 8 458 176) 
					#name: #colorSpace 
					#flags: 8 
					#isOpaque: true)) #(SliderSpec 
				#layout: #(Rectangle 516 9 538 133) 
				#name: #hue 
				#model: #hue 
				#orientation: #vertical 
				#start: 0.999 
				#stop: 0 
				#step: -0.001) #(SliderSpec 
				#layout: #(Rectangle 468 9 490 133) 
				#model: #brightness 
				#orientation: #vertical 
				#start: 1.0 
				#stop: 0.0 
				#step: -0.001) #(SliderSpec 
				#layout: #(Rectangle 492 9 514 133) 
				#name: #saturation 
				#model: #saturation 
				#orientation: #vertical 
				#start: 1.0 
				#stop: 0.0 
				#step: -0.001) #(LabelSpec 
				#layout: #(Point 497 131) 
				#name: #saturationLabel 
				#label: #(UserMessage 
					#key: #S 
					#defaultString: 'S' 
					#catalogID: #labels)) #(ActionButtonSpec 
				#layout: #(Rectangle 290 202 361 232) 
				#name: #setColor 
				#model: #setColor 
				#tabable: false 
				#label: #(UserMessage 
					#key: #Cancel 
					#defaultString: 'Apply' 
					#catalogID: #labels) 
				#defaultable: true) #(ActionButtonSpec 
				#layout: #(Rectangle 389 202 463 232) 
				#name: #applyButton 
				#model: #accept 
				#tabable: false 
				#label: #(UserMessage 
					#key: #OK 
					#defaultString: 'Close' 
					#catalogID: #labels) 
				#isDefault: true) #(SequenceViewSpec 
				#layout: #(Rectangle 8 10 151 229) 
				#name: #ListElements 
				#model: #listElements 
				#useModifierKeys: true 
				#selectionType: #highlight))))
]

{ #category : #'initialize-release' }
MultiColorChooser >> changedList [
	
	| color |
	color := self elementColorDict
		at: self listElements selection
		ifAbsent: [^self selection: ColorValue black].
	self selection: (Cormas colorOrBlackFrom: color)
]

{ #category : #accessing }
MultiColorChooser >> elementColorDict [
	
	^elementColorDict ifNil: [elementColorDict := Dictionary new]
]

{ #category : #accessing }
MultiColorChooser >> elementColorDict: anObject [
	
	elementColorDict := anObject
]

{ #category : #'initialize-release' }
MultiColorChooser >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."
	
	super initialize.
	self listElements selectionIndexHolder onChangeSend: #changedList to: self
]

{ #category : #aspects }
MultiColorChooser >> listElements [
	"This method was generated by UIDefiner.  Any edits made here
	may be lost whenever methods are automatically defined.  The
	initialization provided below may have been preempted by an
	initialize method."
	
	^listElements isNil
		ifTrue: [listElements := SelectionInList new]
		ifFalse: [listElements]
]

{ #category : #'initialize-release' }
MultiColorChooser >> setColor [
	
	self listElements selection
		ifNil: [^Dialog warn: 'Please, select a probe'].
	self elementColorDict
		at: self listElements selection
		put: self selection
]

{ #category : #'initialize-release' }
MultiColorChooser >> setElementColorDictionary: aDictionary [
	
	elementColorDict := aDictionary.
	self listElements list: aDictionary keys asOrderedCollection
]