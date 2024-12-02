import expressAsyncHandler from 'express-async-handler'

import { prisma } from '../../prisma.js'

export const getGoodBuys = expressAsyncHandler(async (req, res) => {
	const allGood = await prisma.goodBuy.findMany({
		orderBy: {
			date: 'desc'
		},
		include: {
			good: true
		}
	})

	res.json(allGood)
})

export const deleteGoodBuy = expressAsyncHandler(async (req, res) => {
	const { id } = req.body

	try {
		const goodBuy = await prisma.goodBuy.delete({
			where: {
				id
			}
		})
	} catch (error) {
		res.status(404)
		throw new Error('Такого товара нет!')
	}
})
