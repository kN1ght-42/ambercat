import busboy from 'busboy'
import expressAsyncHandler from 'express-async-handler'
import fs from 'fs'
import multer from 'multer'

import { prisma } from '../../prisma.js'

export const CreateNewSliderItem = expressAsyncHandler(async (req, res) => {
	const { title, description, bgImageSrc, isActive } = req.body

	const newSliderItem = await prisma.introSlide.create({
		data: {
			title,
			description,
			bgImageSrc,
			isActive: true
		}
	})

	res.json({ newSliderItem })
})

export const getSliderItems = expressAsyncHandler(async (req, res) => {
	const sliderItems = await prisma.introSlide.findMany({
		orderBy: {
			id: 'asc'
		}
	})

	res.json(sliderItems)
})

export const getActiveSliderItems = expressAsyncHandler(async (req, res) => {
	const sliderItems = await prisma.introSlide.findMany({
		where: {
			isActive: true
		}
	})

	res.json(sliderItems)
})

export const updateSliderItems = expressAsyncHandler(async (req, res) => {
	const { title, description, bgImageSrc, isActive } = req.body

	try {
		const sliderItem = await prisma.introSlide.update({
			where: {
				id: +req.body.id
			},
			data: {
				title,
				description,
				bgImageSrc,
				isActive: false
			}
		})

		res.json(sliderItem)
	} catch (error) {
		res.status(404)
		throw new Error('Ошибка. Такого слайдера нет!')
	}
})

export const deleteSliderItems = expressAsyncHandler(async (req, res) => {
	const { id } = req.body

	try {
		const sliderItem = await prisma.introSlide.delete({
			where: {
				id
			}
		})

		res.json({ message: 'Элемент слайдера удален!' })
	} catch (error) {
		res.status(404)
		throw new Error('Элемент слайдера не найден!')
	}
})
