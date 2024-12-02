import fs from 'fs'
import multer from 'multer'
import path from 'path'
import transliterate from 'transliterate-cyrillic-text-to-latin-url'

import { prisma } from '../prisma.js'

const storage = multer.diskStorage({
	destination: (req, file, cb) => {
		switch (file.fieldname) {
			case 'sliderPhoto':
				cb(null, 'uploads/slider')
				break
			case 'goodPhoto':
				const folderName = transliterate(req.body.name)
				const newFolder = `uploads/goods/${folderName}`

				fs.mkdir(
					path.join('uploads/goods', folderName),
					{ recursive: true },
					err => {
						if (err) {
							return console.error(err)
						}
					}
				)
				cb(null, newFolder)
				break
		}
	},
	filename: (req, file, cb) => {
		let i = 1
		switch (file.fieldname) {
			case 'sliderPhoto':
				const fileName = `slider-photo-${
					fs.readdirSync('uploads/slider').length + 1
				}.jpg`

				// console.log(fs.readdirSync('uploads/slider').length)

				cb(null, fileName)
				break
			case 'goodPhoto':
				const goodName = transliterate(req.body.name)

				// console.log(fs.readdirSync(`uploads/goods/${goodName}`))

				const fileName2 = `${goodName}-${
					fs.readdirSync(`uploads/goods/${goodName}`).length
				}.jpg`
				cb(null, fileName2)

				break
		}
	}
})

export const upload = multer({ storage: storage })
