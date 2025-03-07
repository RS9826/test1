
%macro check_for_errors(Activity=);
%PUT Activity =&Activity;
   %if &syserr>4 or &syslibrc>4 
   %then %do;
     %PUT ErrorActivity=&Activity;
	 %PUT syslibrc= &syslibrc;
	 %PUT syserr = &syserr;
%abort cancel;	  
   %end;
%mend check_for_errors;
libname home '$HOME'; 
LIBNAME SQEPHCST ODBC  READ_LOCK_TYPE=NOLOCK  INSERTBUFF=1000  READBUFF=1000  DATASRC=SQL_CORPSQL22_EDW_Hadoop  SCHEMA=claimStd  AuthDomain=SQLAuth ;
LIBNAME SQEPHCPL ODBC  READ_LOCK_TYPE=NOLOCK  READBUFF=1000  INSERTBUFF=1000  DATASRC=SQL_CORPSQL22_EDW_Hadoop  SCHEMA=claimPiiLight  AuthDomain=SQLAuth ;
LIBNAME SQEPHCPI ODBC  READ_LOCK_TYPE=NOLOCK  READBUFF=1000  INSERTBUFF=1000  DATASRC=SQL_CORPSQL22_EDW_Hadoop  SCHEMA=claimPii  AuthDomain=SQLAuth ;
LIBNAME SQEPHCSN ODBC  READ_LOCK_TYPE=NOLOCK  READBUFF=1000  INSERTBUFF=1000  DATASRC=SQL_CORPSQL22_EDW_Hadoop  SCHEMA=claimSsn  AuthDomain=SQLAuth ;
LIBNAME SQEPMSPI ODBC  READ_LOCK_TYPE=NOLOCK  READBUFF=1000  INSERTBUFF=1000  DATASRC=SQL_CORPSQL22_EDW_Hadoop  SCHEMA=membershipPii  AuthDomain=SQLAuth; 
LIBNAME SQEPMSSN ODBC  READ_LOCK_TYPE=NOLOCK  READBUFF=1000  INSERTBUFF=1000  DATASRC=SQL_CORPSQL22_EDW_Hadoop  SCHEMA=membershipSsn  AuthDomain=SQLAuth;
LIBNAME SQEPMSST ODBC  READ_LOCK_TYPE=NOLOCK  READBUFF=1000  INSERTBUFF=1000  DATASRC=SQL_CORPSQL22_EDW_Hadoop  SCHEMA=membershipStd AuthDomain=SQLAuth;
LIBNAME SQEPPVSN META LIBRARY="SQEPPVSN" METAOUT=DATA;
LIBNAME CORE ODBC READ_LOCK_TYPE=NOLOCK DATASRC=SQL_CORPSQL22_EDW_Hadoop SCHEMA=core AuthDomain=SQLAuth readbuff=1000;
libname SQEDWDA odbc datasrc=SQL_EDWRPT_PROD_DataAnalytics read_lock_type=NOLOCK schema=DtAnlytcs authdomain=SQLAuth;
libname MCHIPROD ODBC READ_LOCK_TYPE=NOLOCK DATASRC=SQL_PROD_MedCompass schema=dbo AuthDomain=SASMCHIMAPROD DIRECT_SQL=NOWHERE;

LIBNAME DBCORP META LIBRARY= "DBCORP" Metaout=data; 
LIBNAME DBMCDB META LIBRARY= "DBMCDB" Metaout=data;
LIBNAME DBPRODSY META LIBRARY= "DBPRODSY" Metaout=data; 
LIBNAME DBCMSP META LIBRARY= "DBCMSP" Metaout=data;
LIBNAME CORP META LIBRARY= "DBCORP" Metaout=data;
libname inpr meta library="dbinpr" Metaout=data;
/*LIBNAME MedSIT ODBC READ_LOCK_TYPE=NOLOCK DATASRC=SQL_SIT_MedCompass schema=dbo AuthDomain=MedSIT;*/
/*LIBNAME II META LIBRARY= "SQILPROD" Metaout=data; */
LIBNAME IPPROD META LIBRARY= "SQIPPROD" Metaout=data;

** Working Vendor Data;
libname Vendpii ODBC  DATASRC=SQL_CORPSQL22_EDW_Hadoop  SCHEMA=vendorPii  AuthDomain=SQLAuth READ_LOCK_TYPE=NOLOCK;
LIBNAME sword "/sasdata/SASSUP1/functional/data/COLLABORATIVE/Sword/inbound";
libname Swordout odbc DATASRC=SQL_WDCPSQL14_VCLM authdomain=SQLAuth READ_LOCK_TYPE=NOLOCK schema=SWORD; 
/*
libname strivout odbc DATASRC=SQL_WDCPSQL14_VCLM authdomain=SQLAuth READ_LOCK_TYPE=NOLOCK schema=STRIVE; 
libname wfhout odbc DATASRC=SQL_WDCPSQL14_VCLM authdomain=SQLAuth READ_LOCK_TYPE=NOLOCK schema=wfh; 
libname progout odbc DATASRC=SQL_WDCPSQL14_VCLM authdomain=SQLAuth READ_LOCK_TYPE=NOLOCK schema=PROGENY; 
libname itdbo odbc DATASRC=SQL_WDCPSQL14_VCLM authdomain=SQLAuth READ_LOCK_TYPE=NOLOCK schema=dbo; 
*/

LIBNAME PRODSYS ODBC  DATASRC=DB2_tbcwda8_BCBSODB2P  SCHEMA=PRODSYS AuthDomain=DB2Auth;
LIBNAME DBPRODSY ODBC  DATASRC=DB2_tbcwda8_BCBSODB2P  SCHEMA=PRODSYS AuthDomain=DB2Auth;
LIBNAME CORP ODBC  DATASRC=DB2_tbcwda8_BCBSODB2P  SCHEMA=CORP  AuthDomain=DB2Auth;


/* Vendor program data (Strive, Progeny invoice, Lark): */
libname Vendpii ODBC  DATASRC=SQL_CORPSQL22_EDW_Hadoop  SCHEMA=vendorPii  AuthDomain=SQLAuth READ_LOCK_TYPE=NOLOCK;
/*MedCompass Prod Datamart (Case Mgmt, UM): */
libname MCHIPROD ODBC READ_LOCK_TYPE=NOLOCK DATASRC=SQL_PROD_MedCompass schema=dbo AuthDomain=SASMCHIMAPROD DIRECT_SQL=NOWHERE;


/*CARE MVP*/
LIBNAME OTP '/sasdata/SASHIMAP/PUBLIC/CARE';

/*IPRO schema*/
/*LIBNAME IPHX ODBC DATASRC=SQL_WDCPSQL80_IPRO_PROD SCHEMA=IP_202002*/
/*AuthDomain=SQLAuth READ_LOCK_TYPE=NOLOCK;*/

/*dev library on R to test output*/
/*libname testr '/sasdata/win_shares/corpfs01/GLOBAL/DATA/Health Care Informatics/Employer Group Analytics/Ad Hoc - Special Requests/Completed Reports/Test';*/

libname lookup '/sasdata/SASSUP1/functional/data/Lookup_Tables';
/*libname ccdev '/sasdata/SAS1053A/functional/sas/programs/dev';*/
libname tabdtl '/sasdata/home/es1053/tabdtl';
/*libname a '/sasdata/SASSUP1/functional/data/OPERS Cost and Utilization and Schedule P/2019/Q4';*/
libname h '/sasdata/SASSUP1/functional/data/COLLABORATIVE/HCUP Categories';
libname mem "/sasdata/SASSUP1/functional/data/MembershipDataMart";
libname misc "/sasdata/SASSUP1/functional/data/EMPLOYER GROUP/PHSA/misc";

libname prodsys meta library="dbprodsy" Metaout=data;
libname cmsp meta library="dbcmsp";
libname mcdb meta library="dbmcdb";
libname dattab "/sasdata/SASSUP1/functional/data/Lookup_Tables";
libname adhoc '/sasdata/SASSUP1/functional/data/EMPLOYER GROUP/Ad Hoc Programs/dev';
LIBNAME SQIPPROD ODBC  READ_LOCK_TYPE=NOLOCK  DATASRC=SQL_WDCPSQL80_IPRO_PROD  SCHEMA=dbo  AuthDomain=SQLAuth ;
LIBNAME SQMIPROD ODBC  READ_LOCK_TYPE=NOLOCK  DATASRC=SQL_WDCPSQL80_MMO_IMPACT_PROD  SCHEMA=dbo  AuthDomain=SQLAuth ;
/*LIBNAME SQOHSIM ODBC  READ_LOCK_TYPE=NOLOCK  DATASRC=SQL_WDCPSQL80_OH_SIM  SCHEMA=dbo  AuthDomain=SQLAuth ;*/
libname SQPMI03 odbc read_lock_type=nolock readbuff=1000 insertbuff=1000 datasrc=sql_medinsight_prod_mi_mmo_mart schema=QE authdomain=SQLAuth;
/*libname dattab '/sasdata/SAS1053A/functional/data/reporting/';*/

/*Access the MedInsight Extracts created by MMO’s IT, using the EDW as the source.  These are sent as flat files to Milliman by mid-month, each month and are run through the MedInsight Engine.  */
/*LIBNAME SQPMIEXT ODBC  READ_LOCK_TYPE=NOLOCK  READBUFF=1000  INSERTBUFF=1000  DATASRC=SQL_CORPSQL22_Extracts SCHEMA=medInsight  AuthDomain=SQLAuth;*/
LIBNAME SQPMIMRT ODBC  READ_LOCK_TYPE=NOLOCK  READBUFF=1000  INSERTBUFF=1000  DATASRC=SQL_MEDINSIGHT_PROD_MI_MMO_MART SCHEMA=medInsight  AuthDomain=SQLAuth;

/*LIBNAME SQPMI ODBC  READ_LOCK_TYPE=NOLOCK  READBUFF=1000  INSERTBUFF=1000  DATASRC=SQL_MEDINSIGHT_PROD SCHEMA=medInsight  AuthDomain=SQLAuth;*/
/*libname SQD22EMI meta library="SQD22EMI" METAOUT=data;*/
/*LIBNAME SQD22QE ODBC  READ_LOCK_TYPE=NOLOCK  DATASRC=SQL_corpsqldev22_MI_MMO_MART  SCHEMA=QE  AuthDomain=SQLAuth ;*/
/*LIBNAME SQD22MRT ODBC  READ_LOCK_TYPE=NOLOCK  DATASRC=SQL_corpsqldev22_MI_MMO_MART  SCHEMA=ASRPT  AuthDomain=SQLAuth ;*/

/* Provided by Stephanie on 1/30/25 */

LIBNAME MCHIPROD ODBC READ_LOCK_TYPE=NOLOCK DATASRC=SQL_PROD_MedCompass schema=dbo AuthDomain=SASMCHIMAPROD; /*Libname for MedCompass Reporting Replica PROD*/
LIBNAME MCHIHIST ODBC READ_LOCK_TYPE=NOLOCK DATASRC=SQL_PROD_MedCompass_History schema=dbo AuthDomain=SASMCHIMAPROD; /*Libname for MedCompass Reporting Replica PROD History tables*/
LIBNAME SQEPMSST META LIBRARY= "SQEPMSST" METAOUT=DATA;
LIBNAME SQEPMSSN META LIBRARY= "SQEPMSSN" METAOUT=DATA;
LIBNAME SQEPGMST ODBC  DSN='SQL_CORPSQL22_EDW_Hadoop'  SCHEMA=gbsMembershipStd  AuthDomain=SQLAuth;
LIBNAME SQEPGMSP ODBC  DSN='SQL_CORPSQL22_EDW_Hadoop'  SCHEMA=gbsMembershipPii  AuthDomain=SQLAuth;



