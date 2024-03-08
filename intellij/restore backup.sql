USE master GO
DROP DATABASE [centre-assign]
ALTER DATABASE [centre-assign] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [centre-assign] FROM DISK = '/var/opt/mssql/data/centre-assign-4-7-23-SSC-Centres.BAK';

USE master GO
ALTER DATABASE [boardreg] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE [boardreg]
RESTORE DATABASE [boardreg] FROM DISK = '/var/opt/mssql/data/boardreg-13-july-23-unique-student-ssc-2023-24.BAK';

USE master GO
ALTER DATABASE [masterdata] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE [masterdata]
RESTORE DATABASE [masterdata] FROM DISK = '/var/opt/mssql/data/masterdata-15-5-23.BAK';

USE master GO
ALTER DATABASE [mock] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE [mock]
RESTORE DATABASE [mock] FROM DISK = '/var/opt/mssql/data/mock-15-5-23.BAK';

USE master GO
ALTER DATABASE [IEIMS] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE [IEIMS]
RESTORE DATABASE [IEIMS] FROM DISK = '/var/opt/mssql/data/IEIMS-15-5-23.BAK';

USE master GO
ALTER DATABASE [online-application] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE [online-application]
RESTORE DATABASE [online-application] FROM DISK = '/var/opt/mssql/data/online-application-13-12-23-deb-demo.BAK';

USE master GO
ALTER DATABASE mock SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE mock
RESTORE DATABASE mock FROM DISK = '/var/opt/mssql/data/mock-13-7-23.BAK';


USE master GO
ALTER DATABASE [online-application] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE [online-application]
RESTORE DATABASE [online-application] FROM DISK = '/var/opt/mssql/data/online-application-3-10-23-meb-8-34.BAK';


USE master GO
ALTER DATABASE [auth] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE [auth]
RESTORE DATABASE [auth] FROM DISK = '/var/opt/mssql/data/auth-2-10-23.BAK';


USE master GO
ALTER DATABASE [deb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE [deb]
RESTORE DATABASE [deb] FROM DISK = '/var/opt/mssql/data/deb_24-1-24_1-17-pm.BAK';


USE master GO
ALTER DATABASE [examiner-assignment] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE [examiner-assignment]
RESTORE DATABASE [examiner-assignment] FROM DISK = '/var/opt/mssql/data/eap_14_feb.bak';


USE master GO
ALTER DATABASE [deb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE [deb]
RESTORE DATABASE [deb] FROM DISK = '/var/opt/mssql/data/deb-6-3-24.BAK';


USE master GO
ALTER DATABASE [global] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE [global]
RESTORE DATABASE [global] FROM DISK = '/var/opt/mssql/data/global-6-3-24.BAK';
