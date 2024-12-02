-- CreateTable
CREATE TABLE "good_buys" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER,
    "good_id" INTEGER NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "price" INTEGER NOT NULL,
    "count" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "good_buys_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "good_buys" ADD CONSTRAINT "good_buys_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "good_buys" ADD CONSTRAINT "good_buys_good_id_fkey" FOREIGN KEY ("good_id") REFERENCES "goods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
