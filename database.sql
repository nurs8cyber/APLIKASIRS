-- =========================================================================
-- DATABASE MYSQL UNTUK APLIKASI LOGISTIK RS (XAMPP / PHPMYADMIN)
-- =========================================================================
CREATE DATABASE IF NOT EXISTS db_logistik_rs CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE db_logistik_rs;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    nama VARCHAR(100) NOT NULL,
    peran ENUM('Kepala Unit','Manager','Admin Logistik','Direktur') NOT NULL,
    unit VARCHAR(50) NOT NULL,
    no_wa VARCHAR(30) NOT NULL,
    status VARCHAR(20) DEFAULT 'Aktif'
);

CREATE TABLE IF NOT EXISTS katalog (
    kode VARCHAR(20) PRIMARY KEY,
    nama_barang VARCHAR(150) NOT NULL,
    kategori VARCHAR(50) NOT NULL,
    satuan VARCHAR(30) NOT NULL,
    stok_tersedia INT DEFAULT 0,
    stok_minimum INT DEFAULT 0,
    harga_terakhir DECIMAL(15,2) DEFAULT 0
);

CREATE TABLE IF NOT EXISTS kuota (
    id INT AUTO_INCREMENT PRIMARY KEY,
    unit VARCHAR(50) NOT NULL,
    kode_barang VARCHAR(20) NOT NULL,
    max_minggu INT NULL,
    max_bulan INT NULL
);

CREATE TABLE IF NOT EXISTS pesanan (
    id_pesanan VARCHAR(30) PRIMARY KEY,
    tanggal DATE NOT NULL,
    unit VARCHAR(50) NOT NULL,
    pemesan VARCHAR(100) NOT NULL,
    kode_barang VARCHAR(20) NOT NULL,
    nama_barang VARCHAR(150) NOT NULL,
    jumlah_diminta INT NOT NULL,
    jumlah_disiapkan INT DEFAULT 0,
    harga DECIMAL(15,2) DEFAULT 0,
    status VARCHAR(40) DEFAULT 'Menunggu Manager',
    alasan_tolak TEXT NULL
);

CREATE TABLE IF NOT EXISTS config_iklan (
    id INT PRIMARY KEY DEFAULT 1,
    enabled TINYINT(1) DEFAULT 1,
    media_type ENUM('image','video') DEFAULT 'image',
    judul VARCHAR(200) NOT NULL,
    media_url TEXT NOT NULL,
    target_link TEXT NULL
);

INSERT INTO katalog (kode, nama_barang, kategori, satuan, stok_tersedia, stok_minimum, harga_terakhir) VALUES
('ATK015', 'Pulpen Hitam Standar', 'ATK', 'Pcs', 45, 15, 3500),
('ATK016', 'Pulpen Biru Standar', 'ATK', 'Pcs', 38, 15, 3500),
('RTK002', 'Tisu Kasar / Hand Towel', 'RTK', 'Pack', 12, 20, 14500),
('ATK001', 'Kertas HVS A4 80gr', 'ATK', 'Rim', 28, 10, 52000);

INSERT INTO kuota (unit, kode_barang, max_minggu, max_bulan) VALUES
('FO', 'ATK015', 1, 2),
('FO', 'ATK016', 1, 2),
('LAB', 'RTK002', 2, 4),
('*', 'ATK001', 3, 10);

INSERT INTO config_iklan (id, enabled, media_type, judul, media_url, target_link) VALUES
(1, 1, 'image', 'Sosialisasi Standar Pengamprahan Logistik & Kuota Unit', 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?auto=format&fit=crop&w=900&q=80', 'https://wa.me/6281234567890');
