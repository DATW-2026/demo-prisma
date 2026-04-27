/*
  Warnings:

  - You are about to alter the column `name` on the `genres` table. The data in that column could be lost. The data in that column will be cast from `VarChar(255)` to `VarChar(60)`.
  - You are about to drop the column `firstName` on the `profiles` table. All the data in the column will be lost.
  - You are about to drop the column `lastName` on the `profiles` table. All the data in the column will be lost.
  - You are about to alter the column `avatar` on the `profiles` table. The data in that column could be lost. The data in that column will be cast from `VarChar(255)` to `VarChar(200)`.
  - You are about to drop the `_FilmToGenre` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `first_name` to the `profiles` table without a default value. This is not possible if the table is not empty.
  - Added the required column `surname` to the `profiles` table without a default value. This is not possible if the table is not empty.
  - Added the required column `rate` to the `reviews` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Role" AS ENUM ('USER', 'EDITOR', 'ADMIN');

-- DropForeignKey
ALTER TABLE "_FilmToGenre" DROP CONSTRAINT "_FilmToGenre_A_fkey";

-- DropForeignKey
ALTER TABLE "_FilmToGenre" DROP CONSTRAINT "_FilmToGenre_B_fkey";

-- DropIndex
DROP INDEX "films_title_key";

-- AlterTable
ALTER TABLE "films" ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "poster" DROP NOT NULL,
ALTER COLUMN "poster" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "genres" ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "name" SET DATA TYPE VARCHAR(60);

-- AlterTable
ALTER TABLE "profiles" DROP COLUMN "firstName",
DROP COLUMN "lastName",
ADD COLUMN     "first_name" VARCHAR(200) NOT NULL,
ADD COLUMN     "surname" VARCHAR(200) NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "avatar" SET DATA TYPE VARCHAR(200);

-- AlterTable
ALTER TABLE "reviews" ADD COLUMN     "rate" DECIMAL(3,1) NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "users" ADD COLUMN     "role" "Role" NOT NULL DEFAULT 'USER',
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "password" SET DATA TYPE VARCHAR(255);

-- DropTable
DROP TABLE "_FilmToGenre";

-- CreateTable
CREATE TABLE "_films_genres" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_films_genres_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "_films_genres_B_index" ON "_films_genres"("B");

-- AddForeignKey
ALTER TABLE "_films_genres" ADD CONSTRAINT "_films_genres_A_fkey" FOREIGN KEY ("A") REFERENCES "films"("film_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_films_genres" ADD CONSTRAINT "_films_genres_B_fkey" FOREIGN KEY ("B") REFERENCES "genres"("genre_id") ON DELETE CASCADE ON UPDATE CASCADE;
