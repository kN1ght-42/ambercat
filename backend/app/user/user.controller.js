import { hash } from 'argon2'
import expressAsyncHandler from 'express-async-handler'

import { prisma } from '../prisma.js'
import { UserFields } from '../utils/user.utils.js'

export const getUserProfile = expressAsyncHandler(async (req, res) => {
	const user = await prisma.user.findUnique({
		where: {
			id: +req.user.id
		},
		select: UserFields
	})

	res.json({ user })

	if (!user) {
		res.json({ message: 'Пользователь не найден' })
	}
})

export const updateUserProfile = expressAsyncHandler(async (req, res) => {
	const { firstName, lastName, email, password } = req.body

	let userUpdate

	try {
		if (password) {
			userUpdate = await prisma.user.update({
				where: {
					id: +req.user.id
				},
				data: {
					firstName,
					lastName,
					email,
					password: await hash(password)
				}
			})
		} else {
			userUpdate = await prisma.user.update({
				where: {
					id: +req.user.id
				},
				data: {
					firstName,
					lastName,
					email
				}
			})
		}

		res.json({ userUpdate })
	} catch (error) {
		res.status(404)
		throw new Error('Ошибка при обновлении')
	}
})
