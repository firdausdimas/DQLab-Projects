library(arules)
library(arulesViz)

# Membaca transaksi dari file data_transaksi.txt
transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)

# Menampilkan data transaksi dengan print dan inspect 
inspect(transaksi)

# Menghasilkan model Market Basket Analysis
mba <- apriori(transaksi,parameter = list(supp = 0.1, confidence = 0.5))

# Menampilkan paket produk
inspect(subset(mba, lift>1))


# [Menampilkan Kombinasi dari Contoh Transaksi "Kecil"]


#Membaca transaksi dari file data_transaksi.txt
transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)

# Menampilkan jumlah kombinasi dari produk yang terdapat pada daftar transaksi yang ada
inspect(apriori(transaksi, parameter = list(support=.1, minlen=2, target='frequent itemsets')))


# [Menampilkan Kombinasi dari Transaksi "Besar"]


# Menggunakan library arules
library(arules)

# Membaca transaksi dari file data_transaksi2.txt
transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi2.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)

# Menampilkan jumlah kombinasi dari produk yang terdapat pada daftar transaksi yang ada
inspect(apriori(transaksi, parameter = list(support=.03, minlen=2, target='frequent itemsets')))


# [Membaca File sebagai Data Frame]


# Membaca file yang berlokasi di https://academy.dqlab.id/dataset/data_transaksi.txt 
# dengan fungsi read.csv, dan kemudian disimpan pada variable transaksi_tabular
transaksi_tabular <- read.csv("https://academy.dqlab.id/dataset/data_transaksi.txt", sep="\t")

# Menampilkan variable transaksi_tabular dengan fungsi print
print(transaksi_tabular)


# [Membaca File sebagai Transaction]

read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                  format="single", sep="\t", cols=c(1,2), skip=1)


# [Menampilkan Daftar Item Transaksi]

transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)
transaksi@itemInfo


# [Menampilkan Daftar Kode Transaksi]

transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)
transaksi@itemsetInfo


# [Tampilan Transaksi dalam bentuk Matrix]

transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)
transaksi@data


# [Item Frequency]


transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)
itemFrequency(transaksi, type="absolute")


# [Statistik Top 3]

transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)
data_item <- itemFrequency(transaksi, type="absolute")

# Melakukan sorting pada data_item
data_item <- sort(data_item, decreasing = TRUE)

# Mengambil 3 item pertama
data_item <- data_item[1:3]

# Konversi data_item menjadi data frame dengan kolom Nama_Produk dan Jumlah
data_item <- data.frame("Nama Produk"=names(data_item), "Jumlah"=data_item, row.names=NULL)

print(data_item)


# [Output Statistik Top 3 Sebagai File]

transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)
data_item <- itemFrequency(transaksi, type="absolute")

# Melakukan sorting pada data_item
data_item <- sort(data_item, decreasing = TRUE)

# Mengambil 3 item pertama
data_item <- data_item[1:3]

# Konversi data_item menjadi data frame dengan kolom Nama_Produk dan Jumlah
data_item <- data.frame("Nama Produk"=names(data_item), "Jumlah"=data_item, row.names=NULL)

# Menulis File Statistik Top 3
write.csv(data_item, file="top3_item_retail.txt", eol = "\r\n")


# [Grafik Item Frequency]

transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)

# Tampilan item frequency plot
itemFrequencyPlot(transaksi)


# [Melihat Itemset per Transaksi dengan Inspect]


transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)

# Menggunakan inspect terhadap transaksi
inspect(transaksi)


# [Menghasilkan Rules dengan Apriori]

transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)

# Menghasilkan associaton rules
apriori(transaksi)


# [Melihat Rules dengan fungsi inspect

transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)

# Menghasilkan association rules dan disimpan sebagai variable mba
mba <- apriori(transaksi)

# Melihat isi dari rules dengan menggunakan fungsi inspect
inspect(mba)


# [Filter RHS]

transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)

# Menghasilkan association rules dan disimpan sebagai variable mba
mba <- apriori(transaksi)

# Filter rhs dengan item "Sirup" dan tampilkan
inspect(subset(mba, rhs %in% "Sirup"))


# [Filter LHS]

transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)
mba <- apriori(transaksi)
inspect(subset(mba, lhs %in% "Gula"))


# [Filter LHS dan RHS]


transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)
mba <- apriori(transaksi)
inspect(subset(mba, lhs %in% "Pet Food" & rhs %in% "Sirup"))


# [Menghasilkan Rules dengan Parameter Support dan Confidence]


transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)
apriori(transaksi, parameter = list(supp = 0.1, confidence = 0.5))


# [Inspeksi Rules Yang Dihasilkan]

transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)
apriori(transaksi ,parameter = list(supp = 0.1, confidence = 0.5))
inspect(mba)


# [Filter LHS dan RHS (2)]

transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)
mba <- apriori(transaksi,parameter = list(supp = 0.1, confidence = 0.5))
inspect(subset(mba, lhs %in% "Teh Celup" | rhs %in% "Teh Celup"))


# [Filter berdasarkan Lift]


transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)
mba <- apriori(transaksi,parameter = list(supp = 0.1, confidence = 0.5))
inspect(subset(mba, (lhs %in% "Teh Celup" | rhs %in% "Teh Celup") & lift>1))


# [Rekomendasi - Filter dengan %ain%]

transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt",
                               format="single", sep="\t", cols=c(1,2), skip=1)
mba <- apriori(transaksi,parameter = list(supp = 0.1, confidence = 0.5))
inspect(subset(mba, (lhs %ain% c("Pet Food", "Gula" ))))


# [Visualisasi Rules dengan Graph]


transaksi <- read.transactions(file="https://academy.dqlab.id/dataset/data_transaksi.txt", 
                               format="single", sep="\t", cols=c(1,2), skip=1)
mba <- apriori(transaksi,parameter = list(supp = 0.1, confidence = 0.5))
plot(subset(mba, lift>1.1), method="graph")