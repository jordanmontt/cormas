actions
selectedRowClassNameAsStringLabelPressed
	"This method was generated by UIDefiner.  Any edits made here
	may be lost whenever methods are automatically defined."
	
	| ascSortBlock dscSortBlock sortBlock |
	ascSortBlock := [:x :y | x classNameAsString displayString <= y classNameAsString displayString].
	dscSortBlock := [:x :y | x classNameAsString displayString >= y classNameAsString displayString].
	sortBlock := self methodsForManip_List sortAspect ==
			#selectedRowClassNameAsString
		ifTrue:
			[self methodsForManip_List sortDirection == #asc
				ifTrue:
					[self methodsForManip_List sortDirection: #dsc.
					ascSortBlock]
				ifFalse:
					[self methodsForManip_List sortDirection: #asc.
					dscSortBlock]]
		ifFalse:
			[self methodsForManip_List sortAspect: #selectedRowClassNameAsString.
			self methodsForManip_List sortDirection: #dsc.
			ascSortBlock].
	self methodsForManip_List
		refreshList:
			(SortedCollection
				withAll: self methodsForManip_List list
				sortBlock: sortBlock) asList