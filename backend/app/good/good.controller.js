import expressAsyncHandler from 'express-async-handler'

import { prisma } from '../prisma.js'

export const createGood = expressAsyncHandler(async (req, res) => {
	const {
		name,
		size,
		weight,
		price,
		discount,
		description,
		materialId,
		typeId
	} = req.body

	if (discount > 99 || discount < 0) {
		throw new Error('Недопустимое значение скидки')
	}

	const newGood = await prisma.good.create({
		data: {
			name,
			size,
			weight,
			price: +price,
			discount: +discount,
			description,
			materialId: +materialId,
			typeId: +typeId
		}
	})

	res.json(newGood)
})

export const getAllGoods = expressAsyncHandler(async (req, res) => {
	const allGoods = await prisma.good.findMany({
		orderBy: {
			id: 'asc'
		},
		include: {
			material: true,
			type: true
		}
	})

	res.json(allGoods)
})

export const getGood = expressAsyncHandler(async (req, res) => {
	const good = await prisma.good.findUnique({
		where: {
			id: +req.params.id
		},
		include: {
			material: true,
			type: true
		}
	})

	res.json(good)
})

export const updateGood = expressAsyncHandler(async (req, res) => {
	const {
		name,
		size,
		weight,
		price,
		discount,
		description,
		materialId,
		typeId
	} = req.body

	try {
		const updatedGood = await prisma.good.update({
			where: {
				id
			},
			data: {
				name,
				size,
				weight,
				price,
				discount,
				description,
				materialId,
				typeId
			}
		})

		res.json(updatedGood)
	} catch (error) {
		res.status(404)
		throw new Error('Ошибка. Такого товара нет!')
	}
})

export const deleteGood = expressAsyncHandler(async (req, res) => {
	const { id } = req.body

	try {
		const good = await prisma.good.delete({
			where: {
				id
			}
		})

		res.json({ message: 'Товар удален!' })
	} catch (error) {
		res.status(404)
		throw new Error('Товар не найден!')
	}
})
