/*
  Warnings:

  - The primary key for the `good_buys` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- AlterTable
ALTER TABLE "good_buys" DROP CONSTRAINT "good_buys_pkey",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "good_buys_pkey" PRIMARY KEY ("id");
