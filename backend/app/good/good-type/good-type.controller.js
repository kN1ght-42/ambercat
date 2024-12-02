import expressAsyncHandler from 'express-async-handler'

import { prisma } from '../../prisma.js'

export const createGoodType = expressAsyncHandler(async (req, res) => {
	const { title } = req.body

	const goodType = await prisma.goodType.create({
		data: {
			title
		}
	})

	res.json(goodType)
})

export const getGoodType = expressAsyncHandler(async (req, res) => {
	const goodTypes = await prisma.goodType.findMany({
		orderBy: {
			id: 'asc'
		}
	})

	res.json(goodTypes)
})

export const updateGoodType = expressAsyncHandler(async (req, res) => {
	const { title } = req.body

	try {
		const goodType = await prisma.goodType.update({
			where: {
				id: +req.body.id
			},
			data: {
				title
			}
		})
		res.json(goodType)
	} catch (error) {
		res.status(404)
		throw new Error('Ошибка. Такого вида товаров нет!')
	}
})

export const deleteGoodType = expressAsyncHandler(async (req, res) => {
	const { id } = req.body

	try {
		const goodType = await prisma.goodType.delete({
			where: {
				id
			}
		})
		res.json({ message: 'Вид товара удален!' })
	} catch (error) {
		res.status(404)
		throw new Error('Вид товара не найден!')
	}
})
