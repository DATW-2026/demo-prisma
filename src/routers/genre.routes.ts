import debug from 'debug';
import { Router } from 'express';

import { env } from '../config/env.ts';
import { validateBody, validateId } from '../middleware/validations.ts';
import type { AuthInterceptor } from '../middleware/auth.interceptor.ts';
import type { GenresController } from '../controllers/genres.controller.ts';
import { GenreCreateDTOSchema } from '../zod/film.schemas.ts';

const log = debug(`${env.PROJECT_NAME}:router:genres`);
log('Loading genres router...');

export class GenresRouter {
    #router: Router;
    authInterceptor: AuthInterceptor;
    controller: GenresController;

    constructor(
        controller: GenresController,
        authInterceptor: AuthInterceptor,
    ) {
        log('Starting genres router...');
        this.controller = controller;
        this.authInterceptor = authInterceptor;
        this.#router = Router();

        this.#router.get('/', this.controller.getAllGenres);
        this.#router.get('/:id', validateId(), this.controller.getGenreById);

        this.#router.post(
            '/',
            validateBody(GenreCreateDTOSchema),
            this.authInterceptor.authenticate,
            this.authInterceptor.authorize(['EDITOR']),
            this.controller.createGenre,
        );

        this.#router.put(
            '/:id',
            validateId(),
            validateBody(GenreCreateDTOSchema),
            this.authInterceptor.authenticate,
            this.authInterceptor.authorize(['EDITOR']),
            this.controller.updateGenre,
        );

        this.#router.delete(
            '/:id',
            validateId(),
            this.authInterceptor.authenticate,
            this.authInterceptor.authorize(['EDITOR']),
            this.controller.deleteGenre,
        );
    }

    get router() {
        return this.#router;
    }
}
