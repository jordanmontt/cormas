images - bitmap
fenceHorizontalImage
	"Tools.UIMaskEditor new openOnClass: self andSelector: #fenceHorizontalImage"
	
	<resource: #image>
	^Image
		extent: 51 @ 51
		depth: 2
		bitsPerPixel: 2
		palette:
			(MappedPalette
				withColors:
					(#(#(ColorValue 
						#scaledRed:scaledGreen:scaledBlue: #(0 0 0)) #(ColorValue 
						#scaledRed:scaledGreen:scaledBlue: #(8191 8191 8191)) #(ColorValue 
						#scaledRed:scaledGreen:scaledBlue: #(5557 5557 5557)))
						collect:
							[:each | 
							(each at: 1) value
								perform: (each at: 2)
								withArguments: (each at: 3)]))
		usingBits:
			(ByteArray fromPackedString:
					'UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AUUUUUUUUUUUUUUUUT@@@@UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AP@@@@@@@@@@@@@@@D@@@@T***************!@@@@EJ**************(P@@@AR***************D@@@@T***************!@@@@EJ**************(P@@@AP@@@@@@@@@@@@@@@D@@@@UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AUUUUUUUUUUUUUUUUT@@@@UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AUUUUUUUUUUUUUUUUT@@@@UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AUUUUUUUUUUUUUUUUT@@@@UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AUUUUUUUUUUUUUUUUT@@@@UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AUUUUUUUUUUUUUUUUT@@@@UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AUUUUUUUUUUUUUUUUT@@@@UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AUUUUUUUUUUUUUUUUT@@@@UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AUUUUUUUUUUUUUUUUT@@@@UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AUUUUUUUUUUUUUUUUT@@@@UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AUUUUUUUUUUUUUUUUT@@@@UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AUUUUUUUUUUUUUUUUT@@@@UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AUUUUUUUUUUUUUUUUT@@@@UUUUUUUUUUUUUUUUU@@@@EUUUUUUUUUUUUUUUUP@@@AUUUUUUUUUUUUUUUUT@@@@')