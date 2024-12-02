/*
  Warnings:

  - You are about to drop the `Good` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `GoodBuy` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Good_Material` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Good_Type` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Intro_slide` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Photo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Photo_album` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Role` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Good" DROP CONSTRAINT "Good_material_id_fkey";

-- DropForeignKey
ALTER TABLE "Good" DROP CONSTRAINT "Good_type_id_fkey";

-- DropForeignKey
ALTER TABLE "GoodBuy" DROP CONSTRAINT "GoodBuy_good_id_fkey";

-- DropForeignKey
ALTER TABLE "GoodBuy" DROP CONSTRAINT "GoodBuy_user_id_fkey";

-- DropForeignKey
ALTER TABLE "Photo" DROP CONSTRAINT "Photo_Photo_album_id_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_role_id_fkey";

-- DropTable
DROP TABLE "Good";

-- DropTable
DROP TABLE "GoodBuy";

-- DropTable
DROP TABLE "Good_Material";

-- DropTable
DROP TABLE "Good_Type";

-- DropTable
DROP TABLE "Intro_slide";

-- DropTable
DROP TABLE "Photo";

-- DropTable
DROP TABLE "Photo_album";

-- DropTable
DROP TABLE "Role";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "first_name" TEXT NOT NULL,
    "second_name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "date_of_register" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "role_id" INTEGER NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "goods" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "size" TEXT NOT NULL,
    "weight" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "discont" INTEGER,
    "description" TEXT,
    "material_id" INTEGER NOT NULL,
    "type_id" INTEGER NOT NULL,

    CONSTRAINT "goods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "good_materials" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "good_materials_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "good_types" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "good_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "good_buys" (
    "user_id" INTEGER NOT NULL,
    "good_id" INTEGER NOT NULL,
    "count" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "good_buys_pkey" PRIMARY KEY ("user_id","good_id")
);

-- CreateTable
CREATE TABLE "intro_slides" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "bg_image_src" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL,

    CONSTRAINT "intro_slides_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "photo_albums" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "photo_albums_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "photos" (
    "id" SERIAL NOT NULL,
    "image_src" TEXT NOT NULL,
    "Photo_album_id" INTEGER NOT NULL,

    CONSTRAINT "photos_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goods" ADD CONSTRAINT "goods_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "good_materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goods" ADD CONSTRAINT "goods_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "good_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "good_buys" ADD CONSTRAINT "good_buys_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "good_buys" ADD CONSTRAINT "good_buys_good_id_fkey" FOREIGN KEY ("good_id") REFERENCES "goods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "photos" ADD CONSTRAINT "photos_Photo_album_id_fkey" FOREIGN KEY ("Photo_album_id") REFERENCES "photo_albums"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
