-- CreateTable
CREATE TABLE "users" (
    "user_id" SERIAL NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "password" VARCHAR(24) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "profiles" (
    "profile_id" INTEGER NOT NULL,
    "firstName" VARCHAR(50) NOT NULL,
    "lastName" VARCHAR(50) NOT NULL,
    "avatar" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "profiles_pkey" PRIMARY KEY ("profile_id")
);

-- CreateTable
CREATE TABLE "films" (
    "film_id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "release_year" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "director" VARCHAR(255) NOT NULL,
    "duration" INTEGER NOT NULL,
    "poster" VARCHAR(255) NOT NULL,
    "rate" DECIMAL(2,1) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "films_pkey" PRIMARY KEY ("film_id")
);

-- CreateTable
CREATE TABLE "genres" (
    "genre_id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "genres_pkey" PRIMARY KEY ("genre_id")
);

-- CreateTable
CREATE TABLE "reviews" (
    "user_id" INTEGER NOT NULL,
    "film_id" INTEGER NOT NULL,
    "review" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "reviews_pkey" PRIMARY KEY ("user_id","film_id")
);

-- CreateTable
CREATE TABLE "_FilmToGenre" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_FilmToGenre_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "films_title_key" ON "films"("title");

-- CreateIndex
CREATE UNIQUE INDEX "genres_name_key" ON "genres"("name");

-- CreateIndex
CREATE INDEX "_FilmToGenre_B_index" ON "_FilmToGenre"("B");

-- AddForeignKey
ALTER TABLE "profiles" ADD CONSTRAINT "profiles_profile_id_fkey" FOREIGN KEY ("profile_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_film_id_fkey" FOREIGN KEY ("film_id") REFERENCES "films"("film_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FilmToGenre" ADD CONSTRAINT "_FilmToGenre_A_fkey" FOREIGN KEY ("A") REFERENCES "films"("film_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FilmToGenre" ADD CONSTRAINT "_FilmToGenre_B_fkey" FOREIGN KEY ("B") REFERENCES "genres"("genre_id") ON DELETE CASCADE ON UPDATE CASCADE;
