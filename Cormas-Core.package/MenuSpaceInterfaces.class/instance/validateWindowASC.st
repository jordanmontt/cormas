actions
validateWindowASC
	"This stub method was generated by UIDefiner"
	
	listASCFiles selections
		do: [:f | self supervisor spaceModel getDataFromASCFile: f].	"	self supervisor spaceModel createImages."
	self closeRequest