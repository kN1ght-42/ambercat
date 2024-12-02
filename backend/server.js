import 'colors'
import cors from 'cors'
import dotenv from 'dotenv'
import express from 'express'
import morgan from 'morgan'
import path from 'path'

import { errorHandler, notFound } from './app/middleware/error.middleware.js'

import authRoutes from './app/auth/auth.routes.js'
import goodRoutes from './app/good/good.routes.js'
import { prisma } from './app/prisma.js'
import subsidiaryRouter from './app/subsidiary/subsidiary.routes.js'
import userRoutes from './app/user/user.routes.js'

dotenv.config()

const app = express()

async function main() {
	if (process.env.NODE_ENV === 'development') app.use(morgan('dev'))

	app.use(cors())
	app.use(express.json())

	// const __dirname = path.resolve()

	app.use('/api/auth', authRoutes)
	app.use('/api/user', userRoutes)
	app.use('/api/subsidiary', subsidiaryRouter)
	app.use('/api/good', goodRoutes)

	app.use(notFound)
	app.use(errorHandler)

	const PORT = process.env.PORT

	app.listen(
		PORT,
		console.log(
			`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`
				.green.bold
		)
	)
}

main()
	.then(async () => {
		await prisma.$disconnect()
	})
	.catch(async e => {
		console.log(e)
		await prisma.$disconnect()
		process.exit(1)
	})
