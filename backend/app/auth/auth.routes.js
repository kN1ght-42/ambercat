import express from 'express'

import { protect } from '../middleware/auth.middleware.js'

import { authUser, logOutUser, registerUser } from './auth.controller.js'

const router = express.Router()

router.route('/login').post(authUser)
router.route('/register').post(registerUser)
router.route('/logout').post(logOutUser)

export default router
