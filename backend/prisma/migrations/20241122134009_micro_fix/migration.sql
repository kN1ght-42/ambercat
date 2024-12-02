/*
  Warnings:

  - The primary key for the `good_buys` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Made the column `role_id` on table `users` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "users" DROP CONSTRAINT "users_role_id_fkey";

-- AlterTable
ALTER TABLE "good_buys" DROP CONSTRAINT "good_buys_pkey",
ADD CONSTRAINT "good_buys_pkey" PRIMARY KEY ("good_id");

-- AlterTable
ALTER TABLE "users" ALTER COLUMN "role_id" SET NOT NULL;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
