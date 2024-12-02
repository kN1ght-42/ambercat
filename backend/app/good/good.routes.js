import express from 'express'

import { adminCheck } from '../middleware/admin.middleware.js'
import { protect } from '../middleware/auth.middleware.js'
import { upload } from '../middleware/file.middleware.js'

import { createAuthorizedGoodBuy } from './good-buy/add-authorized-good-buy.controller.js'
import { createUnauthorizedGoodBuy } from './good-buy/add-unauthorized-good-buy.controller.js'
import { getGoodBuys } from './good-buy/good-buy.controller.js'
import {
	createGoodMaterial,
	deleteGoodMaterial,
	getGoodMaterial,
	updateGoodMaterial
} from './good-material/good-material.controller.js'
import {
	createGoodType,
	deleteGoodType,
	getGoodType,
	updateGoodType
} from './good-type/good-type.controller.js'
import {
	createGood,
	deleteGood,
	getAllGoods,
	getGood,
	updateGood
} from './good.controller.js'

const router = express.Router()

router
	.route('/good-material')
	.post([protect, adminCheck], createGoodMaterial)
	.get([protect, adminCheck], getGoodMaterial)
	.put([protect, adminCheck], updateGoodMaterial)
	.delete([protect, adminCheck], deleteGoodMaterial)

router
	.route('/good-type')
	.post([protect, adminCheck], createGoodType)
	.get([protect, adminCheck], getGoodType)
	.put([protect, adminCheck], updateGoodType)
	.delete([protect, adminCheck], deleteGoodType)

router
	.route('/')
	.post(
		[
			protect,
			adminCheck,
			upload.fields([{ name: 'goodPhoto', maxCount: 8 }])
		],
		createGood
	)
	.get(getAllGoods)
	.patch([protect, adminCheck], updateGood)
	.delete([protect, adminCheck], deleteGood)

router
	.route('/good-buy')
	.post(protect, createAuthorizedGoodBuy)
	.get(getGoodBuys)
	.delete([protect, adminCheck], deleteGood)

router.route('/:id').get(getGood)

router.route('/good-buy/unauthorized').post(createUnauthorizedGoodBuy)

export default router
