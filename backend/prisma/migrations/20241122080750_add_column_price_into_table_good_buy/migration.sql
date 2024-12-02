/*
  Warnings:

  - Added the required column `price` to the `good_buys` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "good_buys" ADD COLUMN     "price" INTEGER NOT NULL;
