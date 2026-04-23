import { compare, hash } from 'bcryptjs';
import debug from 'debug';

import { env } from '../config/env.ts';

const log = debug(`${env.PROJECT_NAME}:auth`);
log('Loading auth service...');

// eslint-disable-next-line @typescript-eslint/no-extraneous-class
export class AuthService {
    static hash(password: string): Promise<string> {
        return hash(password, 10);
    }

    static compare(password: string, hash: string): Promise<boolean> {
        return compare(password, hash);
    }
}
