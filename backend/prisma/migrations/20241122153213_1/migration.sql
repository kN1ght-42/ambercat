/*
  Warnings:

  - You are about to drop the `good_buys` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "good_buys" DROP CONSTRAINT "good_buys_good_id_fkey";

-- DropForeignKey
ALTER TABLE "good_buys" DROP CONSTRAINT "good_buys_user_id_fkey";

-- DropTable
DROP TABLE "good_buys";
