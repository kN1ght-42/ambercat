import express from 'express'

import { adminCheck } from '../middleware/admin.middleware.js'
import { protect } from '../middleware/auth.middleware.js'
import { upload } from '../middleware/file.middleware.js'

import {
	CreateNewSliderItem,
	deleteSliderItems,
	getActiveSliderItems,
	getSliderItems,
	updateSliderItems
} from './slider/slider.controller.js'

const router = express.Router()

router
	.route('/intro-slider')
	.post(
		[protect, adminCheck, upload.single('sliderPhoto')],
		CreateNewSliderItem
	)
	.get([protect, adminCheck], getSliderItems)
	.patch([protect, adminCheck], updateSliderItems)
	.delete([protect, adminCheck], deleteSliderItems)

router.route('/').get(getActiveSliderItems)

export default router
