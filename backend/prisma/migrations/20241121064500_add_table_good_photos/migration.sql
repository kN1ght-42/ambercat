-- CreateTable
CREATE TABLE "good_photos" (
    "id" SERIAL NOT NULL,
    "imageSrc" TEXT NOT NULL,
    "good_id" INTEGER NOT NULL,

    CONSTRAINT "good_photos_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "good_photos" ADD CONSTRAINT "good_photos_good_id_fkey" FOREIGN KEY ("good_id") REFERENCES "goods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
