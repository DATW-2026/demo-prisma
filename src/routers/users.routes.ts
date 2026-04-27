import { Router } from 'express';

import { env } from '../config/env.ts';
import debug from 'debug';
import type { UsersController } from '../controllers/users.controller.ts';

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
        this.#router.get('/:id', this.#controller.getUserById);
        this.#router.post('/register', this.#controller.register);
        this.#router.post('/login', this.#controller.login);
        this.router.patch('/:id', this.#controller.updateUser);
        this.router.delete('/:id', this.#controller.deleteUser);
    }

    get router() {
        return this.#router;
    }
}
