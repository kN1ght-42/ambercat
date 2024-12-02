import { verify } from 'argon2'
import { hash } from 'argon2'
import expressAsyncHandler from 'express-async-handler'

import { prisma } from '../prisma.js'
import { UserFields } from '../utils/user.utils.js'

import { generateToken } from './generate-token.js'

export const authUser = expressAsyncHandler(async (req, res) => {
	const { email, password } = req.body

	const user = await prisma.user.findUnique({
		where: {
			email
		}
	})

	const isValidPassword = await verify(user.password, password)

	if (user && isValidPassword) {
		const token = generateToken(user.id)

		res.json({
			user,
			token
		})

		const headers = new Headers()
	} else {
		res.status(401)
		throw new Error('Неверный логин или пароль')
	}
})

export const registerUser = expressAsyncHandler(async (req, res) => {
	const { firstName, lastName, email, password } = req.body

	const isHaveUser = await prisma.user.findUnique({
		where: { email }
	})

	if (isHaveUser) {
		res.status(400)
		throw new Error(
			'Пользователь с такой электронной почтой уже зарегистрирован'
		)
	}

	const user = await prisma.user.create({
		data: {
			firstName,
			lastName,
			email,
			password: await hash(password),
			roleId: 2
		},
		select: UserFields
	})

	const token = generateToken(user.id)

	res.json({
		user,
		token
	})
})

export const logOutUser = expressAsyncHandler(async (req, res) => {})
