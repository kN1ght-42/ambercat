/*
  Warnings:

  - Added the required column `role_id` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "User" ADD COLUMN     "role_id" INTEGER NOT NULL,
ALTER COLUMN "date_of_register" SET DEFAULT CURRENT_TIMESTAMP;

-- CreateTable
CREATE TABLE "Role" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Good" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "size" TEXT NOT NULL,
    "weight" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "discont" INTEGER,
    "description" TEXT,
    "material_id" INTEGER NOT NULL,
    "type_id" INTEGER NOT NULL,

    CONSTRAINT "Good_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Good_Material" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "Good_Material_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Good_Type" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "Good_Type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GoodBuy" (
    "user_id" INTEGER NOT NULL,
    "good_id" INTEGER NOT NULL,
    "count" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "GoodBuy_pkey" PRIMARY KEY ("user_id","good_id")
);

-- CreateTable
CREATE TABLE "intro_slide" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "bg_image_src" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL,

    CONSTRAINT "intro_slide_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "photo_album" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "photo_album_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Photo" (
    "id" SERIAL NOT NULL,
    "image_src" TEXT NOT NULL,
    "photo_album_id" INTEGER NOT NULL,

    CONSTRAINT "Photo_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Good" ADD CONSTRAINT "Good_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "Good_Material"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Good" ADD CONSTRAINT "Good_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "Good_Type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GoodBuy" ADD CONSTRAINT "GoodBuy_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GoodBuy" ADD CONSTRAINT "GoodBuy_good_id_fkey" FOREIGN KEY ("good_id") REFERENCES "Good"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Photo" ADD CONSTRAINT "Photo_photo_album_id_fkey" FOREIGN KEY ("photo_album_id") REFERENCES "photo_album"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
