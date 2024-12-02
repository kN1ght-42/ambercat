/*
  Warnings:

  - You are about to drop the column `photo_album_id` on the `Photo` table. All the data in the column will be lost.
  - You are about to drop the `intro_slide` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `photo_album` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `Photo_album_id` to the `Photo` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Photo" DROP CONSTRAINT "Photo_photo_album_id_fkey";

-- AlterTable
ALTER TABLE "Photo" DROP COLUMN "photo_album_id",
ADD COLUMN     "Photo_album_id" INTEGER NOT NULL;

-- DropTable
DROP TABLE "intro_slide";

-- DropTable
DROP TABLE "photo_album";

-- CreateTable
CREATE TABLE "Intro_slide" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "bg_image_src" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL,

    CONSTRAINT "Intro_slide_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Photo_album" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "Photo_album_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Photo" ADD CONSTRAINT "Photo_Photo_album_id_fkey" FOREIGN KEY ("Photo_album_id") REFERENCES "Photo_album"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
