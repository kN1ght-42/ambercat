import expressAsyncHandler from 'express-async-handler'

import { prisma } from '../../prisma.js'

export const createGoodMaterial = expressAsyncHandler(async (req, res) => {
	const { title } = req.body

	const goodMaterial = await prisma.goodMaterial.create({
		data: {
			title
		}
	})

	res.json(goodMaterial)
})

export const getGoodMaterial = expressAsyncHandler(async (req, res) => {
	const goodMaterials = await prisma.goodMaterial.findMany({
		orderBy: {
			id: 'asc'
		}
	})

	res.json(goodMaterials)
})

export const updateGoodMaterial = expressAsyncHandler(async (req, res) => {
	const { title } = req.body

	try {
		const goodMaterial = await prisma.goodMaterial.update({
			where: {
				id: +req.body.id
			},
			data: {
				title
			}
		})
		res.json(goodMaterial)
	} catch (error) {
		res.status(404)
		throw new Error('Ошибка. Такого товара нет!')
	}
})

export const deleteGoodMaterial = expressAsyncHandler(async (req, res) => {
	const { id } = req.body

	try {
		const goodMaterial = await prisma.goodMaterial.delete({
			where: {
				id
			}
		})

		res.json({ message: 'Материал товара удален!' })
	} catch (error) {
		res.status(404)
		throw new Error('Материал товара не найден!')
	}
})
