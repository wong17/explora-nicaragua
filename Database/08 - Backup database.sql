-- CREATE BACKUP
BACKUP DATABASE [NicaraguaTourismDB] 
TO DISK = 'E:\Repositories\proyectoSOR\Database\NicaraguaTourismDB.bak'
WITH 
	INIT, 
	FORMAT, 
	NAME = 'Full Backup - NicaraguaTourismDB', 
	COMPRESSION, 
	CHECKSUM, 
	STATS = 10;