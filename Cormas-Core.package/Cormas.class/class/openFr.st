deprecated
openFr
	"avant c'√©tait #fr mais il fallait recharger (FileIn) Locale.st.
	#fr => #'fr_FR.CP1252' 
	#en => #'en_US.CP1252' "
	
	self openInterface: #windowSpec WithLanguage: #'fr_FR.CP1252'