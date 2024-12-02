import expressAsyncHandler from 'express-async-handler'
import jwt from 'jsonwebtoken'

import { prisma } from '../prisma.js'

export const adminCheck = expressAsyncHandler(async (req, res, next) => {
	let token = req.headers.authorization.split(' ')[1]

	const decoded = jwt.verify(token, process.env.JWT_SECRET)

	const userFound = await prisma.user.findUnique({
		where: {
			id: decoded.userId
		}
	})

	if (userFound.roleId === 1) {
		next()
	} else {
		res.status(404)
		throw new Error('Страница не найдена')
	}
})
