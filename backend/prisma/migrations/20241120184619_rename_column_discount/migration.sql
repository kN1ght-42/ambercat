/*
  Warnings:

  - You are about to drop the column `discont` on the `goods` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "goods" DROP COLUMN "discont",
ADD COLUMN     "discount" INTEGER;
