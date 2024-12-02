-- DropForeignKey
ALTER TABLE "good_buys" DROP CONSTRAINT "good_buys_user_id_fkey";

-- AlterTable
ALTER TABLE "good_buys" ALTER COLUMN "user_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "good_buys" ADD CONSTRAINT "good_buys_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
