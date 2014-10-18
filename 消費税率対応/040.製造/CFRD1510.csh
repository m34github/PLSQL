#!/usr/bin/csh
#
# �v���W�F�N�g : NAM�ږ◿�f�C���[�Z�o�V�X�e��
# �@�\��       : ����SS�p�O���ϑ������v��z�ڑ��t�@�C���쐬
# �t�@�C����   : CFRD1510.csh
#
# �g�p���@     : % CFRD1510.csh [�����t]
# �g�p��       : % CFRD1510.csh �܂���     ���ʏ�^�p
#                  CFRD1510.csh YYYYMMDD
# ����       1 : WK_SJ_PEX_DATE : �C�ӓ��͈��� : ��csh�p�����t
#                  �{�ԉ^�p�ł͐ݒ肵�Ȃ��B
#                  �E�D�揇��
#                  1.���������ݒ肳��Ă����ꍇ
#                    ������������t�Ƃ��Ďg�p����(��csh���̂݁j
#                    �����l�̑Ó����`�F�b�N
#                    (NUMERIC�|CHECK�A����`�F�b�N�A�c�Ɠ��`�F�b�N)�͍s��Ȃ��B
#                  2.���������ݒ肳��Ă��Ȃ��ꍇ
#                    2.1�@���ϐ�  SJ_PEX_DATE���ݒ肳��Ă����ꍇ
#                         SJ_PEX_DATE������t�Ƃ��Ďg�p����B���ʏ�^�p
#                    2.2�@���ϐ�  SJ_PEX_DATE���ݒ肳��Ă��Ȃ��ꍇ
#                         UNIX�̃}�V�����t������t�Ƃ��Ďg�p����(��csh���̂�)
#
# EXIT STATUS  : 0   :����
#              : 255 :�ُ�
# �쐬��       : 2009/02/28
# �쐬��       : SRA�Č�
#
# �X�V��       : 2009/07/21
# �X�V��       : SRA�Č�
# �X�V�T�v     : 200906-04.���M�O���ϑ��ږ◿��SSJ�ڑ��ǉ��Ή�
#                SJIS�̌_�񖼏̂�SSJ�t�@�C���Ɏ������邱�ƂɂȂ������߁A
#                SSJ�t�@�C���� SJIS��UTF-8�ɕϊ����鏈����ǉ�
#
# �X�V��       : 2014/02/18
# �X�V��       : GUT���y
# �X�V�T�v     : 2014-02-18.����őΉ�
#                CFRD1510_SQL5INSTMP3��ǉ�
#
################################################################################

#################
#  ��������     #
#################
##  �I���X�e�[�^�X�̃Z�b�g ##
set CFR_OK     = 0
set CFR_NG     = 255
set CFR_WAIT   = 1
set sts        = ${CFR_OK}
set exitsts    = ${CFR_WAIT}

##  ���ʊ��ϐ��ݒ�  ##
set MYHOSTNAME = `hostname`
switch ($MYHOSTNAME)
    case "ODWNRI"
        set MY_SETENV_DIR = /export/home/cfrbt1/work/test/lib
        set MY_SETENV_FILE = cfr_setenv
        breaksw
    default
        set MY_SETENV_DIR = /gen00/cfr/lib
        set MY_SETENV_FILE = cfr_setenv
        breaksw
endsw

if ( ! -f $MY_SETENV_DIR/$MY_SETENV_FILE ) then
    set exitsts = ${CFR_NG}
    echo "[$0 $*] [abnomal-end]=[$exitsts][cannot find setenv-file=[$MY_SETENV_DIR/$MY_SETENV_FILE]] `date '+%Y/%m/%d-%H:%M:%S'`"
    exit $exitsts
endif

if ( ! -r $MY_SETENV_DIR/$MY_SETENV_FILE ) then
    set exitsts = ${CFR_NG}
    echo "[$0 $*] [abnomal-end]=[$exitsts][cannot read setenv-file=[$MY_SETENV_DIR/$MY_SETENV_FILE]] `date '+%Y/%m/%d-%H:%M:%S'`"
    exit $exitsts
endif

source $MY_SETENV_DIR/$MY_SETENV_FILE
set sts = $status
if ( $sts != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "[$0 $*] [abnomal-end]=[$exitsts][error source setenv-file=[$MY_SETENV_DIR/$MY_SETENV_FILE]] `date '+%Y/%m/%d-%H:%M:%S'`"
    exit $exitsts
endif

##  logfile�ݒ� ##
set thisdate    = "date '+%Y%m%d'"              # ���ݓ��t
set thispgmpath = $0                            # foo/var.hoge
set thispgmhead = $thispgmpath:r                # foo/var
set thisname    = $thispgmhead:t                # var

printenv CFR_LOGDIR >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "[$0 $*] [abnormal-end]=[cannot getenv CFR_LOGDIR] `date '+%Y/%m/%d-%H:%M:%S'`"
    exit $exitsts
endif

if ( ! -d $CFR_LOGDIR ) then
    set exitsts = ${CFR_NG}
    echo "[$0 $*] [abnormal-end]=[cannot find CFR_LOGDIR=[$CFR_LOGDIR]] `date '+%Y/%m/%d-%H:%M:%S'`"
    exit $exitsts
endif

if ( ! -r $CFR_LOGDIR ) then
    set exitsts = ${CFR_NG}
    echo "[$0 $*] [abnormal-end]=[cannot read CFR_LOGDIR=[$CFR_LOGDIR]] `date '+%Y/%m/%d-%H:%M:%S'`"
    exit $exitsts
endif

if ( ! -w $CFR_LOGDIR ) then
    set exitsts = ${CFR_NG}
    echo "[$0 $*] [abnormal-end]=[cannot write CFR_LOGDIR=[$CFR_LOGDIR]] `date '+%Y/%m/%d-%H:%M:%S'`"
    exit $exitsts
endif

setenv CFR_LOGFILENAME    ${thisname}_`eval ${thisdate}`.log
set logfile  = ${CFR_LOGDIR}/${CFR_LOGFILENAME} # ���O�t�@�C����

##  �J�n���b�Z�[�W�o��  ##
echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] SS�pXML�t�@�C���쐬�J�n ###" >>&! ${logfile}

##  ���ϐ��`�F�b�N  ##
####  ���ϐ�:ORACLE���[�UID �`�F�b�N  ####
printenv CFR_ORAUID >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] ORACLE�̃��[�UID ���ݒ肳��Ă��܂��� [CFR_ORAUID] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:ORACLE�p�X���[�h �`�F�b�N  ####
printenv CFR_ORAPWD >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] ORACLE�̃p�X���[�h ���ݒ肳��Ă��܂��� [CFR_ORAPWD] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:ORACLESID �`�F�b�N  ####
printenv CFR_ORASID >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] ORACLE��SID ���ݒ肳��Ă��܂��� [CFR_ORASID] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:SS�]���t�@�C��(XML)�쐬�f�B���N�g�� �`�F�b�N  ####
printenv CFR_SS_MAKEFILEDIR >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �]�����f�B���N�g��(XML�쐬�f�B���N�g��)���ݒ肳��Ă��܂��� [CFR_SS_MAKEFILEDIR] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -d $CFR_SS_MAKEFILEDIR ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�]�����f�B���N�g��(XML�쐬�f�B���N�g��)������܂��� [CFR_SS_MAKEFILEDIR]=[$CFR_SS_MAKEFILEDIR] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_SS_MAKEFILEDIR ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�]�����f�B���N�g��(XML�쐬�f�B���N�g��)�ɓǍ�����������܂��� [CFR_SS_MAKEFILEDIR]=[$CFR_SS_MAKEFILEDIR] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -w $CFR_SS_MAKEFILEDIR ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�]�����f�B���N�g��(XML�쐬�f�B���N�g��)�ɏ�������������܂��� [CFR_SS_MAKEFILEDIR]=[$CFR_SS_MAKEFILEDIR] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:SQL�i�[�f�B���N�g�� �`�F�b�N  ####
printenv CFR_SQL_DIR >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] SQL�i�[�f�B���N�g�����ݒ肳��Ă��܂��� [CFR_SQL_DIR] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -d $CFR_SQL_DIR ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽSQL�i�[�f�B���N�g��������܂��� [CFR_SQL_DIR]=[$CFR_SQL_DIR] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_SQL_DIR ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽSQL�i�[�f�B���N�g���ɓǍ�����������܂��� [CFR_SQL_DIR]=[$CFR_SQL_DIR] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:AWK�i�[�f�B���N�g�� �`�F�b�N  ####
printenv CFR_AWK_DIR >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] AWK�i�[�f�B���N�g�����ݒ肳��Ă��܂��� [CFR_AWK_DIR] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -d $CFR_AWK_DIR ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽAWK�i�[�f�B���N�g��������܂��� [CFR_AWK_DIR]=[$CFR_AWK_DIR] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_AWK_DIR ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽAWK�i�[�f�B���N�g���ɓǍ�����������܂��� [CFR_AWK_DIR]=[$CFR_AWK_DIR] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:XmlFormat�i�[�f�B���N�g�� �`�F�b�N  ####
printenv CFR_XMLFORMAT_DIR >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] XMLFORMAT�i�[�f�B���N�g�����ݒ肳��Ă��܂��� [CFR_XMLFORMAT_DIR] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -d $CFR_XMLFORMAT_DIR ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽXMLFORMAT�i�[�f�B���N�g��������܂��� [CFR_XMLFORMAT_DIR]=[$CFR_XMLFORMAT_DIR] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_XMLFORMAT_DIR ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽXMLFORMAT�i�[�f�B���N�g���ɓǍ�����������܂��� [CFR_XMLFORMAT_DIR]=[$CFR_XMLFORMAT_DIR] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:TMPFILE�i�[�f�B���N�g�� �`�F�b�N  ####
printenv CFR_TMPDIR >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] TMPFILE�i�[�f�B���N�g�����ݒ肳��Ă��܂��� [CFR_TMPDIR] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -d $CFR_TMPDIR ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽTMPFILE�i�[�f�B���N�g��������܂��� [CFR_TMPDIR]=[$CFR_TMPDIR] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_TMPDIR ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽTMPFILE�i�[�f�B���N�g���ɓǍ�����������܂��� [CFR_TMPDIR]=[$CFR_TMPDIR] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -w $CFR_TMPDIR ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽTMPFILE�i�[�f�B���N�g���ɏ�������������܂��� [CFR_TMPDIR]=[$CFR_TMPDIR] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:XML�^�OIN_SYS_CODE�ݒ�l �`�F�b�N  ####
printenv CFRD1510_IN_SYS_CODE >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] XML�^�OIN_SYS_CODE�ݒ�l���ݒ肳��Ă��܂��� [CFRD1510_IN_SYS_CODE] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:�������pTMP�t�@�C�� �`�F�b�N  ####
printenv CFRD1510_TMPFILE >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������pTMP�t�@�C�����ݒ肳��Ă��܂��� [CFRD1510_TMPFILE] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:�������pCSV�t�@�C�� �`�F�b�N  ####
printenv CFRD1510_CSVFILE >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������pCSV�t�@�C�����ݒ肳��Ă��܂��� [CFRD1510_CSVFILE] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:�������pSQL�t�@�C�� �`�F�b�N  ####
######  SQL0
printenv CFRD1510_SQL0GETYOKU >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������pSQL�t�@�C�����ݒ肳��Ă��܂��� [CFRD1510_SQL0GETYOKU] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -f $CFR_SQL_DIR/$CFRD1510_SQL0GETYOKU ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C��������܂��� [CFRD1510_SQL0GETYOKU]=[$CFR_SQL_DIR/$CFRD1510_SQL0GETYOKU] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_SQL_DIR/$CFRD1510_SQL0GETYOKU ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C���ɓǍ�����������܂��� [CFRD1510_SQL0GETYOKU]=[$CFR_SQL_DIR/$CFRD1510_SQL0GETYOKU] ###" >>&! ${logfile}
    goto EndProc
endif

######  SQL1
printenv CFRD1510_SQL1TRUNTMP >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������pSQL�t�@�C�����ݒ肳��Ă��܂��� [CFRD1510_SQL1TRUNTMP] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -f $CFR_SQL_DIR/$CFRD1510_SQL1TRUNTMP ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C��������܂��� [CFRD1510_SQL1TRUNTMP]=[$CFR_SQL_DIR/$CFRD1510_SQL1TRUNTMP] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_SQL_DIR/$CFRD1510_SQL1TRUNTMP ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C���ɓǍ�����������܂��� [CFRD1510_SQL1TRUNTMP]=[$CFR_SQL_DIR/$CFRD1510_SQL1TRUNTMP] ###" >>&! ${logfile}
    goto EndProc
endif

######  SQL2
printenv CFRD1510_SQL2INSTMP1 >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������pSQL�t�@�C�����ݒ肳��Ă��܂��� [CFRD1510_SQL2INSTMP1] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -f $CFR_SQL_DIR/$CFRD1510_SQL2INSTMP1 ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C��������܂��� [CFRD1510_SQL2INSTMP1]=[$CFR_SQL_DIR/$CFRD1510_SQL2INSTMP1] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_SQL_DIR/$CFRD1510_SQL2INSTMP1 ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C���ɓǍ�����������܂��� [CFRD1510_SQL2INSTMP1]=[$CFR_SQL_DIR/$CFRD1510_SQL2INSTMP1] ###" >>&! ${logfile}
    goto EndProc
endif

######  SQL3
printenv CFRD1510_SQL3UPDTMP1 >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������pSQL�t�@�C�����ݒ肳��Ă��܂��� [CFRD1510_SQL3UPDTMP1] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -f $CFR_SQL_DIR/$CFRD1510_SQL3UPDTMP1 ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C��������܂��� [CFRD1510_SQL3UPDTMP1]=[$CFR_SQL_DIR/$CFRD1510_SQL3UPDTMP1] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_SQL_DIR/$CFRD1510_SQL3UPDTMP1 ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C���ɓǍ�����������܂��� [CFRD1510_SQL3UPDTMP1]=[$CFR_SQL_DIR/$CFRD1510_SQL3UPDTMP1] ###" >>&! ${logfile}
    goto EndProc
endif

######  SQL4
printenv CFRD1510_SQL4UPDTMP1 >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������pSQL�t�@�C�����ݒ肳��Ă��܂��� [CFRD1510_SQL4UPDTMP1] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -f $CFR_SQL_DIR/$CFRD1510_SQL4UPDTMP1 ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C��������܂��� [CFRD1510_SQL4UPDTMP1]=[$CFR_SQL_DIR/$CFRD1510_SQL4UPDTMP1] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_SQL_DIR/$CFRD1510_SQL4UPDTMP1 ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C���ɓǍ�����������܂��� [CFRD1510_SQL4UPDTMP1]=[$CFR_SQL_DIR/$CFRD1510_SQL4UPDTMP1] ###" >>&! ${logfile}
    goto EndProc
endif

######  SQL5
printenv CFRD1510_SQL5INSTMP2 >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������pSQL�t�@�C�����ݒ肳��Ă��܂��� [CFRD1510_SQL5INSTMP2] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -f $CFR_SQL_DIR/$CFRD1510_SQL5INSTMP2 ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C��������܂��� [CFRD1510_SQL5INSTMP2]=[$CFR_SQL_DIR/$CFRD1510_SQL5INSTMP2] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_SQL_DIR/$CFRD1510_SQL5INSTMP2 ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C���ɓǍ�����������܂��� [CFRD1510_SQL5INSTMP2]=[$CFR_SQL_DIR/$CFRD1510_SQL5INSTMP2] ###" >>&! ${logfile}
    goto EndProc
endif

#    2014-02-18.����őΉ� START
printenv CFRD1510_SQL5INSTMP3 >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������pSQL�t�@�C�����ݒ肳��Ă��܂��� [CFRD1510_SQL5INSTMP3] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -f $CFR_SQL_DIR/$CFRD1510_SQL5INSTMP3 ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C��������܂��� [CFRD1510_SQL5INSTMP3]=[$CFR_SQL_DIR/$CFRD1510_SQL5INSTMP3] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_SQL_DIR/$CFRD1510_SQL5INSTMP3 ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C���ɓǍ�����������܂��� [CFRD1510_SQL5INSTMP3]=[$CFR_SQL_DIR/$CFRD1510_SQL5INSTMP3] ###" >>&! ${logfile}
    goto EndProc
endif
#    2014-02-18.����őΉ� END

######  SQL6
printenv CFRD1510_SQL6SELTMP2 >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������pSQL�t�@�C�����ݒ肳��Ă��܂��� [CFRD1510_SQL6SELTMP2] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -f $CFR_SQL_DIR/$CFRD1510_SQL6SELTMP2 ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C��������܂��� [CFRD1510_SQL6SELTMP2]=[$CFR_SQL_DIR/$CFRD1510_SQL6SELTMP2] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_SQL_DIR/$CFRD1510_SQL6SELTMP2 ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C���ɓǍ�����������܂��� [CFRD1510_SQL6SELTMP2]=[$CFR_SQL_DIR/$CFRD1510_SQL6SELTMP2] ###" >>&! ${logfile}
    goto EndProc
endif

######  SQL7
printenv CFRD1510_SQL7INS_STS >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������pSQL�t�@�C�����ݒ肳��Ă��܂��� [CFRD1510_SQL7INS_STS] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -f $CFR_SQL_DIR/$CFRD1510_SQL7INS_STS ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C��������܂��� [CFRD1510_SQL7INS_STS]=[$CFR_SQL_DIR/$CFRD1510_SQL7INS_STS] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_SQL_DIR/$CFRD1510_SQL7INS_STS ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pSQL�t�@�C���ɓǍ�����������܂��� [CFRD1510_SQL7INS_STS]=[$CFR_SQL_DIR/$CFRD1510_SQL7INS_STS] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:XMLFORMAT�t�@�C�� �`�F�b�N  ####
######  XMLFORMAT_ZERO
printenv CFRD1510_XMLFORMAT0 >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������pXML���`�t�@�C�����ݒ肳��Ă��܂��� [CFRD1510_XMLFORMAT0] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -f $CFR_XMLFORMAT_DIR/$CFRD1510_XMLFORMAT0 ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pXML���`�t�@�C��������܂��� [CFRD1510_XMLFORMAT0]=[$CFR_XMLFORMAT_DIR/$CFRD1510_XMLFORMAT0] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_XMLFORMAT_DIR/$CFRD1510_XMLFORMAT0 ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pXML���`�t�@�C���ɓǍ�����������܂��� [CFRD1510_XMLFORMAT0]=[$CFR_XMLFORMAT_DIR/$CFRD1510_XMLFORMAT0] ###" >>&! ${logfile}
    goto EndProc
endif

######  XMLFORMAT_SOME
printenv CFRD1510_XMLFORMATS >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������pXML���`�t�@�C�����ݒ肳��Ă��܂��� [CFRD1510_XMLFORMATS] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -f $CFR_XMLFORMAT_DIR/$CFRD1510_XMLFORMATS ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pXML���`�t�@�C��������܂��� [CFRD1510_XMLFORMATS]=[$CFR_XMLFORMAT_DIR/$CFRD1510_XMLFORMATS] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_XMLFORMAT_DIR/$CFRD1510_XMLFORMATS ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pXML���`�t�@�C���ɓǍ�����������܂��� [CFRD1510_XMLFORMATS]=[$CFR_XMLFORMAT_DIR/$CFRD1510_XMLFORMATS] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:�������pAWK�t�@�C�� �`�F�b�N  ####
printenv CFRD1510_AWKMAKEXMLS >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������pAWK�t�@�C�����ݒ肳��Ă��܂��� [CFRD1510_AWKMAKEXMLS] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -f $CFR_AWK_DIR/$CFRD1510_AWKMAKEXMLS ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pAWK�t�@�C��������܂��� [CFRD1510_AWKMAKEXMLS]=[$CFR_AWK_DIR/$CFRD1510_AWKMAKEXMLS] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -r $CFR_AWK_DIR/$CFRD1510_AWKMAKEXMLS ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �w�肳�ꂽ�������pAWK�t�@�C���ɓǍ�����������܂��� [CFRD1510_AWKMAKEXMLS]=[$CFR_AWK_DIR/$CFRD1510_AWKMAKEXMLS] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:SS�X�e�[�^�X�e�[�u���ۑ��N�� �`�F�b�N  ####
printenv CFR_SS_SAVE_YEAR >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] SS�X�e�[�^�X�e�[�u���ۑ��N�����ݒ肳��Ă��܂��� [CFR_SS_SAVE_YEAR] ###" >>&! ${logfile}
    goto EndProc
endif

####  ���ϐ�:SS�ő匏�� �`�F�b�N  ####
printenv CFR_SS_MAX_NUMBER >& /dev/null
if ( $status != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] SS�ő匏�����ݒ肳��Ă��܂��� [CFR_SS_MAX_NUMBER] ###" >>&! ${logfile}
    goto EndProc
endif

##  ��csh�p�����t�ݒ�  ##
####  ������(�C��:��csh�p�����t)
####      ��csh�p�����t
####      �����������ϐ�SJ_PEX_DATE��UNIX�̃}�V�����t
if ($#argv > 0) then
    setenv WK_SJ_PEX_DATE $1
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] ���������ݒ肳��Ă��邽�߁A��csh�p�����t��[$WK_SJ_PEX_DATE]�Ƃ��܂� ###" >>&! ${logfile}
else
    printenv SJ_PEX_DATE >& /dev/null
    if ( $status == ${CFR_OK} ) then
        setenv WK_SJ_PEX_DATE $SJ_PEX_DATE
        echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] ���������ݒ肳��Ă��Ȃ����߁A��csh�p�����t�����ϐ�SJ_PEX_DATE�̒l[$WK_SJ_PEX_DATE]�Ƃ��܂� ###" >>&! ${logfile}
    else
        setenv WK_SJ_PEX_DATE `date '+%Y%m%d'`
        echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] ���������ݒ肳��Ă��Ȃ����߁A��csh�p�����t��UNX�}�V�����t�̒l[$WK_SJ_PEX_DATE]�Ƃ��܂� ###" >>&! ${logfile}
    endif
endif

##  ��csh�p���c�Ɠ��擾  ##
\rm -f $CFR_TMPDIR/$CFRD1510_TMPFILE >& /dev/null
set sts = $status
if ( $sts != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] ���c�Ɠ��擾�O��TMPFILE�폜�ŃG���[���������܂���[rm error]=[$sts] TMPFILE=[CFRD1510_TMPFILE]=[$CFR_TMPDIR/$CFRD1510_TMPFILE] ###" >>&! ${logfile}
    goto EndProc
endif

sqlplus -S $CFR_ORAUID/$CFR_ORAPWD@$CFR_ORASID << _EOF_  >>&! ${logfile}
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
SET AUTOCOMMIT OFF
@$CFR_SQL_DIR/$CFRD1510_SQL0GETYOKU
$CFR_TMPDIR
$CFRD1510_TMPFILE
$WK_SJ_PEX_DATE
_EOF_

set sts = $status
if ( $sts != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] ���c�Ɠ��擾�ŃG���[���������܂���[sqlplus error]=[$sts] SQLFILE=[CFRD1510_SQL0GETYOKU]=[$CFR_SQL_DIR/$CFRD1510_SQL0GETYOKU] ###" >>&! ${logfile}
    goto EndProc
endif

if ( ! -f $CFR_TMPDIR/$CFRD1510_TMPFILE ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] ���c�Ɠ��擾�pTMPFILE(SPOOLFILE)���쐬����Ă��܂���[CFRD1510_TMPFILE]=[$CFR_TMPDIR/$CFRD1510_TMPFILE] ###" >>&! ${logfile}
    goto EndProc
endif

set WK_YOKUEI_YYYYMMDD = `grep '^[0-9]\{8\}$' $CFR_TMPDIR/$CFRD1510_TMPFILE`
set sts = $status
if ( $sts != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] ���c�Ɠ��擾�ŃG���[���������܂���[function error]=[$sts] SQLFILE=[CFRD1510_SQL0GETYOKU]=[$CFR_SQL_DIR/$CFRD1510_SQL0GETYOKU] ###" >>&! ${logfile}
    goto EndProc
endif

echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �������p���c�Ɠ�=[$WK_YOKUEI_YYYYMMDD] ###" >>&! ${logfile}

##############################
#  XML�쐬�p���ԃe�[�u������ #
##############################
echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] XML�쐬�p���ԃe�[�u���쐬�J�n ###" >>&! ${logfile}

\rm -f $CFR_TMPDIR/$CFRD1510_TMPFILE >& /dev/null
set sts = $status
if ( $sts != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] ���ԃe�[�u���쐬�O��TMPFILE�폜�ŃG���[���������܂���[rm error]=[$sts] TMPFILE=[CFRD1510_TMPFILE]=[$CFR_TMPDIR/$CFRD1510_TMPFILE] ###" >>&! ${logfile}
    goto EndProc
endif

#    2014-02-18.����őΉ�(CFRD1510_SQL5INSTMP3��ǉ�) START
sqlplus -S $CFR_ORAUID/$CFR_ORAPWD@$CFR_ORASID << _EOF_  >>&! ${logfile}
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
SET AUTOCOMMIT OFF
@$CFR_SQL_DIR/$CFRD1510_SQL1TRUNTMP
@$CFR_SQL_DIR/$CFRD1510_SQL2INSTMP1
$WK_YOKUEI_YYYYMMDD
$thisname
$CFR_SS_SAVE_YEAR
@$CFR_SQL_DIR/$CFRD1510_SQL3UPDTMP1
@$CFR_SQL_DIR/$CFRD1510_SQL4UPDTMP1
@$CFR_SQL_DIR/$CFRD1510_SQL5INSTMP3
@$CFR_SQL_DIR/$CFRD1510_SQL5INSTMP2
@$CFR_SQL_DIR/$CFRD1510_SQL6SELTMP2
$CFR_TMPDIR
$CFRD1510_TMPFILE
COMMIT;
EXIT SQL.SQLCODE
_EOF_
#    2014-02-18.����őΉ�(CFRD1510_SQL5INSTMP3��ǉ�) END

set sts = $status
if ( $sts != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] XML�쐬�p���ԃe�[�u���쐬�ŃG���[���������܂���[sqlplus error]=[$sts] ###" >>&! ${logfile}
    goto EndProc
endif

echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] XML�쐬�p���ԃe�[�u���쐬�I�� ###" >>&! ${logfile}

##################################
#  XML�쐬�pCSV�t�@�C���쐬����  #
##################################
echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] XML�쐬�pCSV�t�@�C���쐬�J�n ###" >>&! ${logfile}

if ( ! -f $CFR_TMPDIR/$CFRD1510_TMPFILE ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] CSV�쐬�pTMPFILE(SPOOLFILE)���쐬����Ă��܂���[CFRD1510_TMPFILE]=[$CFR_TMPDIR/$CFRD1510_TMPFILE] ###" >>&! ${logfile}
    goto EndProc
endif

\rm -f $CFR_TMPDIR/$CFRD1510_CSVFILE >& /dev/null
set sts = $status
if ( $sts != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] CSV�쐬�O��CSVFILE�폜�ŃG���[���������܂���[rm error]=[$sts] CSVFILE=[CFRD1510_CSVFILE]=[$CFR_TMPDIR/$CFRD1510_CSVFILE] ###" >>&! ${logfile}
    goto EndProc
endif

sed -e '1,$s/ *	/	/g' $CFR_TMPDIR/$CFRD1510_TMPFILE | sed -e '1,$s/	 */	/g' | sed -e '1,$s/ALLSPACE-ALLSPACE/ /g' >&! $CFR_TMPDIR/$CFRD1510_CSVFILE

echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] XML�쐬�pCSV�t�@�C���쐬�I�� ###" >>&! ${logfile}

#########################
#  XML�t�@�C���쐬����  #
#########################
echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] XML�t�@�C���쐬�J�n ###" >>&! ${logfile}

if ( ! -f $CFR_TMPDIR/$CFRD1510_CSVFILE ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] XML�t�@�C���쐬�pCSVFILE���쐬����Ă��܂���[CFRD1510_CSVFILE]=[$CFR_TMPDIR/$CFRD1510_CSVFILE] ###" >>&! ${logfile}
    goto EndProc
endif

## ���������`�F�b�N ##
@ WK_CSV_KENSU = `wc -l $CFR_TMPDIR/$CFRD1510_CSVFILE | nawk '{print $1}'`
if ( $WK_CSV_KENSU > $CFR_SS_MAX_NUMBER ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �Ώی�����SS�ő匏�����I�[�o�[���܂��� [SS�ő匏��]=[$CFR_SS_MAX_NUMBER] [�Ώی���]=[$WK_CSV_KENSU] CSV�t�@�C��=[$CFR_TMPDIR/CFRD1510_CSVFILE] ###" >>&! ${logfile}
    goto EndProc
endif

set WK_XMLFILENAME0 = "NAMD_A8_${WK_YOKUEI_YYYYMMDD}0000.xml"
set WK_XMLFILENAMES = "NAMD_A8_${WK_YOKUEI_YYYYMMDD}.xml"

\rm -f $CFR_SS_MAKEFILEDIR/$WK_XMLFILENAME0 >& /dev/null
set sts = $status
if ( $sts != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] XML�쐬�O�̃[�����pXML�t�@�C���폜�ŃG���[���������܂���[rm error]=[$sts] XMLFILE=[WK_XMLFILENAME0]=[$CFR_SS_MAKEFILEDIR/$WK_XMLFILENAME0] ###" >>&! ${logfile}
    goto EndProc
endif

\rm -f $CFR_SS_MAKEFILEDIR/$WK_XMLFILENAMES >& /dev/null
set sts = $status
if ( $sts != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] XML�쐬�O��1���ȏ�pXML�t�@�C���폜�ŃG���[���������܂���[rm error]=[$sts] XMLFILE=[WK_XMLFILENAMES]=[$CFR_SS_MAKEFILEDIR/$WK_XMLFILENAMES] ###" >>&! ${logfile}
    goto EndProc
endif

## �[�����pXML�t�@�C���쐬���� ##
if ( -z $CFR_TMPDIR/$CFRD1510_CSVFILE ) then
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �[�����pXML�t�@�C�����쐬���܂� ###" >>&! ${logfile}

    sed -e '/^[ 	]*<\!--/d' -e '/^[ 	]*$/d' -e "s/CHG_SYS_CODE/$CFRD1510_IN_SYS_CODE/" -e "s/CHG_DATA_YMD/$WK_YOKUEI_YYYYMMDD/" $CFR_XMLFORMAT_DIR/$CFRD1510_XMLFORMAT0 >&! $CFR_SS_MAKEFILEDIR/$WK_XMLFILENAME0

    set sts = $status
    if ( $sts != ${CFR_OK} ) then
        set exitsts = ${CFR_NG}
        echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �[�����pXML�t�@�C���쐬�ŃG���[���������܂���[sed error]=[$sts] XMLFILE=[WK_XMLFILENAME0]=[$CFR_SS_MAKEFILEDIR/$WK_XMLFILENAME0] ###" >>&! ${logfile}
        goto EndProc
    endif

    if ( ! -f $CFR_SS_MAKEFILEDIR/$WK_XMLFILENAME0 ) then
        set exitsts = ${CFR_NG}
        echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �[�����pXML�t�@�C���̍쐬�Ɏ��s���܂���[WK_XMLFILENAME0]=[$CFR_SS_MAKEFILEDIR/$WK_XMLFILENAME0] ###" >>&! ${logfile}
        goto EndProc
    endif

    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] �[�����pXML�t�@�C�����쐬���܂���  XMLFILE=[WK_XMLFILENAME0]=[$CFR_SS_MAKEFILEDIR/$WK_XMLFILENAME0] ###" >>&! ${logfile}

## 1���ȏ�pXML�t�@�C���쐬���� ##
else
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] 1���ȏ�pXML�t�@�C�����쐬���܂� ###" >>&! ${logfile}
#    200906-04.���M�O���ϑ��ږ◿��SSJ�ڑ��ǉ��Ή� START   
#    cat $CFR_XMLFORMAT_DIR/$CFRD1510_XMLFORMATS $CFR_TMPDIR/$CFRD1510_CSVFILE | sed -e '/^[ 	]*<\!--/d' -e '/^[ 	]*$/d' | nawk -f $CFR_AWK_DIR/$CFRD1510_AWKMAKEXMLS >&! $CFR_SS_MAKEFILEDIR/$WK_XMLFILENAMES
    cat $CFR_XMLFORMAT_DIR/$CFRD1510_XMLFORMATS $CFR_TMPDIR/$CFRD1510_CSVFILE | sed -e '/^[ 	]*<\!--/d' -e '/^[ 	]*$/d' | nawk -f $CFR_AWK_DIR/$CFRD1510_AWKMAKEXMLS | iconv -f SJIS -t UTF-8 >&! $CFR_SS_MAKEFILEDIR/$WK_XMLFILENAMES
#    200906-04.���M�O���ϑ��ږ◿��SSJ�ڑ��ǉ��Ή� END   

    set sts = $status
    if ( $sts != ${CFR_OK} ) then
        set exitsts = ${CFR_NG}
        echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] 1���ȏ�pXML�t�@�C���쐬�ŃG���[���������܂���[cat/sed/nawk error]=[$sts] XMLFILE=[WK_XMLFILENAMES]=[$CFR_SS_MAKEFILEDIR/$WK_XMLFILENAMES] ###" >>&! ${logfile}
        goto EndProc
    endif

    if ( ! -f $CFR_SS_MAKEFILEDIR/$WK_XMLFILENAMES ) then
        set exitsts = ${CFR_NG}
        echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] 1���ȏ�pXML�t�@�C���̍쐬�Ɏ��s���܂���[WK_XMLFILENAMES]=[$CFR_SS_MAKEFILEDIR/$WK_XMLFILENAMES] ###" >>&! ${logfile}
        goto EndProc
    endif

    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] 1���ȏ�pXML�t�@�C�����쐬���܂���  XMLFILE=[WK_XMLFILENAMES]=[$CFR_SS_MAKEFILEDIR/$WK_XMLFILENAMES] ###" >>&! ${logfile}

endif

echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] XML�t�@�C���쐬�I�� ###" >>&! ${logfile}

##################################
#  SS�X�e�[�^�X�e�[�u���o�^���� ##
##################################
echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] SS�X�e�[�^�X�o�^�J�n ###" >>&! ${logfile}

sqlplus -S $CFR_ORAUID/$CFR_ORAPWD@$CFR_ORASID << _EOF_  >>&! ${logfile}
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
SET AUTOCOMMIT OFF
@$CFR_SQL_DIR/$CFRD1510_SQL7INS_STS
$WK_YOKUEI_YYYYMMDD
$thisname
COMMIT;
EXIT SQL.SQLCODE
_EOF_

set sts = $status
if ( $sts != ${CFR_OK} ) then
    set exitsts = ${CFR_NG}
    echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] SS�X�e�[�^�X�o�^�ŃG���[���������܂���[sqlplus error]=[$sts] ###" >>&! ${logfile}
    goto EndProc
endif

echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] SS�X�e�[�^�X�o�^�I�� ###" >>&! ${logfile}
set exitsts = ${CFR_OK}

#################
#  �I������     #
#################
EndProc:

switch (${exitsts})
    case ${CFR_OK}:
        echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] SS�pXML�t�@�C���쐬����I�� status=[$exitsts] ###" >>&! ${logfile}
        breaksw
    default:
        echo "### [$thisname][`date '+%Y/%m/%d-%H:%M:%S'`] SS�pXML�t�@�C���쐬�ُ�I�� status=[$exitsts] ###" >>&! ${logfile}
        breaksw
endsw

exit (${exitsts})
