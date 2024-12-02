import expressAsyncHandler from 'express-async-handler'

import { prisma } from '../../prisma.js'

export const createUnauthorizedGoodBuy = expressAsyncHandler(
	async (req, res) => {
		const { goodId, name, email, count } = req.body

		try {
			const goodPrice = await prisma.good.findUnique({
				where: {
					id: goodId
				},
				select: {
					price: true
				}
			})

			const newGoodBuy = await prisma.goodBuy.create({
				data: {
					goodId,
					name,
					email,
					count,
					price: goodPrice.price
				}
			})

			res.json(newGoodBuy)
		} catch (error) {
			res.status(404)
			throw new Error('Ошибка. Такого товара нет!')
		}
	}
)
