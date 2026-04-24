import { Router } from 'express';

import { env } from '../config/env.ts';
import debug from 'debug';
import type { UsersController } from '../controllers/users-controller.ts';

const log = debug(`${env.PROJECT_NAME}:router:users`);
log('Loading Users router...');

export class UsersRouter {
    #_router: Router;
    #controller: UsersController;

    constructor(controller: UsersController) {
        log('Starting Users router...');
        this.#controller = controller;
        this.#_router = Router();

        this.#_router.get(
            '/:id',
            this.#controller.getUserById.bind(this.#controller),
        );
    }
}
