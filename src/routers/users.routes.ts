import { Router } from 'express';

import { env } from '../config/env.ts';
import debug from 'debug';
import type { UsersController } from '../controllers/users.controller.ts';
import { validateBody, validateId } from '../middleware/validations.ts';
import {
    RegisterUserDTOSchema,
    UpdateUserDTOSchema,
    UserCredentialsDTOSchema,
} from '../zod/user.schemas.ts';

const log = debug(`${env.PROJECT_NAME}:router:users`);
log('Loading Users router...');

export class UsersRouter {
    #controller: UsersController;
    #router: Router;

    constructor(controller: UsersController) {
        log('Starting Users router...');
        this.#controller = controller;
        this.#router = Router();

        this.router.get('/', this.#controller.getAllUsers);
        this.#router.get('/:id', validateId(), this.#controller.getUserById);

        this.#router.post(
            '/register',
            validateBody(RegisterUserDTOSchema),
            this.#controller.register,
        );
        this.#router.post(
            '/login',
            validateBody(UserCredentialsDTOSchema),
            this.#controller.login,
        );

        this.#router.patch(
            '/:id',
            validateId(),
            validateBody(UpdateUserDTOSchema),
            this.#controller.updateUser,
        );

        this.#router.delete('/:id', validateId(), this.#controller.deleteUser);
    }

    get router() {
        return this.#router;
    }
}
