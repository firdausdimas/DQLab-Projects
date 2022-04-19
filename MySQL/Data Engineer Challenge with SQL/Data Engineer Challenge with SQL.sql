#-- Produk DQLab Mart --#
-- tampilkan daftar produk yang memiliki harga antara 50.000 and 150.000. --

SELECT 
    no_urut, kode_produk, nama_produk, harga
FROM
    ms_produk
WHERE
    harga > 50000 AND harga < 150000;

#-- Thumb drive di DQLab Mart --#
-- Tampilkan semua produk yang mengandung kata Flashdisk. --

SELECT 
    no_urut, kode_produk, nama_produk, harga
FROM
    ms_produk
WHERE
    nama_produk LIKE '%Flashdisk%';

#-- Pelanggan Bergelar --#
-- Tampilkan hanya nama-nama pelanggan yang hanya memiliki gelar-gelar berikut: S.H, Ir. dan Drs. --

SELECT 
    no_urut, kode_pelanggan, nama_pelanggan, alamat
FROM
    ms_pelanggan
WHERE
    nama_pelanggan LIKE '%S.H%'
        OR nama_pelanggan LIKE '%Ir.%'
        OR nama_pelanggan LIKE '%Drs.%';

#-- Mengurutkan Nama Pelanggan --#
-- Tampilkan nama-nama pelanggan dan urutkan hasilnya berdasarkan kolom nama_pelanggan- 
-- dari yang terkecil ke yang terbesar (A ke Z). --

SELECT 
    nama_pelanggan
FROM
    ms_pelanggan
ORDER BY nama_pelanggan;

#-- Mengurutkan Nama Pelanggan Tanpa Gelar --#
-- Tampilkan nama-nama pelanggan dan urutkan hasilnya berdasarkan kolom nama_pelanggan- 
-- dari yang terkecil ke yang terbesar (A ke Z), namun gelar tidak boleh menjadi bagian dari urutan.- 
-- Contoh: Ir. Agus Nugraha harus berada di atas Heidi Goh. --

SELECT 
    nama_pelanggan
FROM
    ms_pelanggan
ORDER BY SUBSTRING_INDEX(nama_pelanggan, '. ', - 1);

#-- Nama Pelanggan yang Paling Panjang --#
-- Tampilkan nama pelanggan yang memiliki nama paling panjang.-
-- Jika ada lebih dari 1 orang yang memiliki panjang nama yang sama, tampilkan semuanya. --

SELECT 
    nama_pelanggan
FROM
    ms_pelanggan
WHERE
    LENGTH(nama_pelanggan) = (SELECT 
            MAX(LENGTH(nama_pelanggan))
        FROM
            ms_pelanggan);

#-- Nama Pelanggan yang Paling Panjang dengan Gelar --#
-- Tampilkan nama orang yang memiliki nama paling panjang (pada row atas), dan nama orang paling pendek- 
-- (pada row setelahnya). Gelar menjadi bagian dari nama.-
-- Jika ada lebih dari satu nama yang paling panjang atau paling pendek, harus ditampilkan semuanya. --

SELECT 
    nama_pelanggan
FROM
    ms_pelanggan
WHERE
    LENGTH(nama_pelanggan) IN ((SELECT 
            MAX(LENGTH(nama_pelanggan))
        FROM
            ms_pelanggan) , (SELECT 
                MIN(LENGTH(nama_pelanggan))
            FROM
                ms_pelanggan))
ORDER BY LENGTH(nama_pelanggan) DESC;

#-- Kuantitas Produk yang Banyak Terjual --#
-- Tampilkan produk yang paling banyak terjual dari segi kuantitas.-
-- Jika ada lebih dari 1 produk dengan nilai yang sama, tampilkan semua produk tersebut. --

SELECT 
    ms_produk.kode_produk,
    ms_produk.nama_produk,
    SUM(tr_penjualan_detail.qty) AS total_qty
FROM
    ms_produk
        INNER JOIN
    tr_penjualan_detail ON ms_produk.kode_produk = tr_penjualan_detail.kode_produk
GROUP BY ms_produk.kode_produk , ms_produk.nama_produk
HAVING SUM(tr_penjualan_detail.qty) > 2;

#-- Pelanggan Paling Tinggi Nilai Belanjanya --#
-- Siapa saja pelanggan yang paling banyak menghabiskan uangnya untuk belanja?-
-- Jika ada lebih dari 1 pelanggan dengan nilai yang sama, tampilkan semua pelanggan tersebut. --

SELECT 
    tr_penjualan.kode_pelanggan,
    ms_pelanggan.nama_pelanggan,
    SUM(tr_penjualan_detail.qty * tr_penjualan_detail.harga_satuan) AS total_harga
FROM
    ms_pelanggan
        INNER JOIN
    tr_penjualan USING (kode_pelanggan)
        INNER JOIN
    tr_penjualan_detail USING (kode_transaksi)
GROUP BY tr_penjualan.kode_pelanggan , ms_pelanggan.nama_pelanggan
ORDER BY total_harga DESC
LIMIT 1;

#-- Pelanggan yang Belum Pernah Berbelanja --#

SELECT 
    kode_pelanggan, nama_pelanggan, alamat
FROM
    ms_pelanggan
WHERE
    kode_pelanggan NOT IN (SELECT 
            kode_pelanggan
        FROM
            tr_penjualan);

#-- Transaksi Belanja dengan Daftar Belanja lebih dari 1 --#
-- Tampilkan transaksi-transaksi yang memiliki jumlah item produk lebih dari 1 jenis produk.- 
-- Dengan lain kalimat, tampilkan transaksi-transaksi yang memiliki jumlah baris data pada- 
-- table tr_penjualan_detail lebih dari satu. --

SELECT 
    tr.kode_transaksi,
    tr.kode_pelanggan,
    ms.nama_pelanggan,
    tr.tanggal_transaksi,
    COUNT(td.qty) AS jumlah_detail
FROM
    tr_penjualan tr
        INNER JOIN
    ms_pelanggan ms ON tr.kode_pelanggan = ms.kode_pelanggan
        INNER JOIN
    tr_penjualan_detail td ON tr.kode_transaksi = td.kode_transaksi
GROUP BY tr.kode_transaksi , tr.kode_pelanggan , ms.nama_pelanggan , tr.tanggal_transaksi
HAVING jumlah_detail > 1;