CREATE TABLE	CFR_TMP_SS01_TBL(
	KUGIRI_1	CHAR(40)	,	/* KUGIRI_1 */
	KAI_CODE	CHAR(5)	NOT NULL,	/* ��ЃR�[�h */
	IN_SYS_CODE	CHAR(10)	NOT NULL,	/* ���̓V�X�e���R�[�h */
	IN_SYS_DATE	NUMBER(8)	NOT NULL,	/* ���̓V�X�e�����t */
	IN_SYS_DATA_NO	NUMBER(8)	NOT NULL,	/* ���̓V�X�e���f�[�^�� */
	SWK_ID	CHAR(5)	NOT NULL,	/* ���͎d��h�c */
	KESSAN_KBN	CHAR(1)	NOT NULL,	/* ���Z�d��敪 */
	IN_USR_ID	CHAR(10)	NOT NULL,	/* ���̓��[�U�[ID */
	DEN_NO	CHAR(8)	NOT NULL,	/* �`�[�ԍ� */
	GYO_NO	NUMBER(5)	NOT NULL,	/* ���׍s�ԍ� */
	DR_KMK_CODE	CHAR(10)	,	/* �ؕ�����ȖڃR�[�h */
	DR_HKM_CODE	CHAR(10)	,	/* �ؕ��⏕�ȖڃR�[�h */
	DR_BMN_CODE	CHAR(10)	,	/* �ؕ�����R�[�h */
	DR_CODE1	CHAR(10)	,	/* �ؕ��@�\�R�[�h1 */
	DR_CODE2	CHAR(10)	,	/* �ؕ��@�\�R�[�h2 */
	DR_CODE3	CHAR(10)	,	/* �ؕ��@�\�R�[�h3 */
	DR_CODE4	CHAR(10)	,	/* �ؕ��@�\�R�[�h4 */
	DR_KIN	NUMBER(21,3)	,	/* �ؕ��~�݋��z�i�Ŕ��j */
	DR_CUR_CODE	CHAR(3)	,	/* �ؕ��O�݃R�[�h */
	DR_CRT_RATE_TYPE	CHAR(2)	,	/* �ؕ����[�g�^�C�v */
	DR_CRT_RATE	NUMBER(17,12)	,	/* �ؕ����Z���[�g */
	DR_CUR_KIN	NUMBER(21,3)	,	/* �ؕ��O�݋��z */
	DR_ZEI_CODE	CHAR(4)	,	/* �ؕ��ŏ����R�[�h */
	DR_ZEI_KBN	CHAR(1)	,	/* �ؕ��œ��͋敪 */
	DR_ZEI_KIN	NUMBER(21,3)	,	/* �ؕ��Ŋz */
	DR_TEKIYO1	VARCHAR2(40)	,	/* �ؕ��E�v1 */
	DR_TEKIYO2	VARCHAR2(40)	,	/* �ؕ��E�v2 */
	DR_TORI_KBN	CHAR(1)	,	/* �ؕ������敪 */
	DR_TORI_CODE	CHAR(20)	,	/* �ؕ������R�[�h */
	CR_KMK_CODE	CHAR(10)	,	/* �ݕ�����ȖڃR�[�h */
	CR_HKM_CODE	CHAR(10)	,	/* �ݕ��⏕�ȖڃR�[�h */
	CR_BMN_CODE	CHAR(10)	,	/* �ݕ�����R�[�h */
	CR_CODE1	CHAR(10)	,	/* �ݕ��@�\�R�[�h1 */
	CR_CODE2	CHAR(10)	,	/* �ݕ��@�\�R�[�h2 */
	CR_CODE3	CHAR(10)	,	/* �ݕ��@�\�R�[�h3 */
	CR_CODE4	CHAR(10)	,	/* �ݕ��@�\�R�[�h4 */
	CR_KIN	NUMBER(21,3)	,	/* �ݕ��~�݋��z�i�Ŕ��j */
	CR_CUR_CODE	CHAR(3)	,	/* �ݕ��O�݃R�[�h */
	CR_CRT_RATE_TYPE	CHAR(2)	,	/* �ݕ����[�g�^�C�v */
	CR_CRT_RATE	NUMBER(17,12)	,	/* �ݕ����Z���[�g */
	CR_CUR_KIN	NUMBER(21,3)	,	/* �ݕ��O�݋��z */
	CR_ZEI_CODE	CHAR(4)	,	/* �ݕ��ŏ����R�[�h */
	CR_ZEI_KBN	CHAR(1)	,	/* �ݕ��œ��͋敪 */
	CR_ZEI_KIN	NUMBER(21,3)	,	/* �ݕ��Ŋz */
	CR_TEKIYO1	VARCHAR2(40)	,	/* �ݕ��E�v1 */
	CR_TEKIYO2	VARCHAR2(40)	,	/* �ݕ��E�v2 */
	CR_TORI_KBN	CHAR(1)	,	/* �ݕ������敪 */
	CR_TORI_CODE	CHAR(20)	,	/* �ݕ������R�[�h */
	SWK_JYO1	CHAR(20)	,	/* �d���������1 */
	SWK_JYO2	CHAR(20)	,	/* �d���������2 */
	SWK_JYO3	CHAR(20)	,	/* �d���������3 */
	SWK_JYO4	CHAR(20)	,	/* �d���������4 */
	SWK_JYO5	CHAR(20)	,	/* �d���������5 */
	KAIKEI_KOUMOKU1	VARCHAR(40)	,	/* �Ǘ���v�p����1 */
	KAIKEI_KOUMOKU2	VARCHAR(40)	,	/* �Ǘ���v�p����2 */
	KAIKEI_KOUMOKU3	VARCHAR(40)	,	/* �Ǘ���v�p����3 */
	KAIKEI_KOUMOKU4	VARCHAR(40)	,	/* �Ǘ���v�p����4 */
	KAIKEI_KOUMOKU5	VARCHAR(40)	,	/* �Ǘ���v�p����5 */
	KANRI_COMMENT1	VARCHAR(40)	,	/* �Ǘ��p�R�����g1 */
	KANRI_COMMENT2	VARCHAR(40)	,	/* �Ǘ��p�R�����g2 */
	KANRI_COMMENT3	VARCHAR(40)	,	/* �Ǘ��p�R�����g3 */
	KANRI_COMMENT4	VARCHAR(40)	,	/* �Ǘ��p�R�����g4 */
	KANRI_COMMENT5	VARCHAR(40)	,	/* �Ǘ��p�R�����g5 */
	KANRI_COMMENT6	VARCHAR(40)	,	/* �Ǘ��p�R�����g6 */
	KANRI_COMMENT7	VARCHAR(40)	,	/* �Ǘ��p�R�����g7 */
	KANRI_COMMENT8	VARCHAR(40)	,	/* �Ǘ��p�R�����g8 */
	KANRI_COMMENT9	VARCHAR(40)	,	/* �Ǘ��p�R�����g9 */
	KANRI_COMMENT10	VARCHAR(40)	,	/* �Ǘ��p�R�����g10 */
	AUS_FLG_01	CHAR(1)	,	/* �ꎟ���F�t���O */
	AU_USR_ID_01	CHAR(10)	,	/* �ꎟ���F���[�U�[ID */
	AUS_DATE_01	NUMBER(8)	,	/* �ꎟ���F�� */
	AUS_FLG_02	CHAR(1)	,	/* �񎟏��F�t���O */
	AU_USR_ID_02	CHAR(10)	,	/* �񎟏��F���[�U�[ID */
	AUS_DATE_02	NUMBER(8)	,	/* �񎟏��F�� */
	SYO_FLG	CHAR(1)	,	/* �����t���O */
	KUGIRI_2	CHAR(40)	,	/* KUGIRI_2 */
	ZEN_BASE_MONTH	CHAR(6)			NOT NULL,	/* �O���� */
	ZEN_SETTLEMENT_DATE	CHAR(8)		NOT NULL,	/* �O����� */
	KUGIRI_3	CHAR(40)	,	/* KUGIRI_3 */
	J_CONTRACT_NO	CHAR(20)		NOT NULL,	/* �_��ԍ� */
	J_BASE_MONTH	CHAR(6)			NOT NULL,	/* ��� */
	J_CURRENCY_CODE	CHAR(3)	DEFAULT '999'	NOT NULL,	/* �ʉ݃R�[�h */
	J_ASSET_TYPE_CODE	CHAR(3)	DEFAULT '999'	NOT NULL,	/* ���Y��ʃR�[�h */
	J_SETTLEMENT_DATE	CHAR(8)		NOT NULL,	/* ���� */
	J_FIX_COM_FLAG	CHAR(1)	DEFAULT '0'	NOT NULL,	/* �m��O���ϑ��ږ◿���͋敪 */
	J_FIX_COM_J		NUMBER(18,3),			/* �m��O���ϑ��ږ◿�i�~�j */
	KUGIRI_4	CHAR(40)	,	/* KUGIRI_4 */
	K_CONTRACT_NO	CHAR(20)		NOT NULL,	/* �_��ԍ� */
	K_INSERT_DATE	CHAR(8)		NOT NULL,	/* �o�^�� */
	K_CONTRACT_FLAG	CHAR(1)	DEFAULT '1'	NOT NULL,	/* �_��敪 */
	K_COMPANY_CODE	CHAR(4)		NOT NULL,	/* �^�p��ЃR�[�h */
	K_COM_CALC_START	CHAR(8)			,	/* �ږ◿�v�Z�J�n�� */
	K_TAX_CALC_FLAG	CHAR(1)	DEFAULT '0'	NOT NULL,	/* ����Ōv�Z�L�� */
/*       2014-02-11 ����őΉ� START */
	K_ADV_LEAVE_FLAG	CHAR(1)	DEFAULT '0'	NOT NULL,	/* �����^��C�敪 */
/*       2014-02-11 ����őΉ� STOP */
	K_INVALID_FLAG	CHAR(1)	DEFAULT '0'	NOT NULL,	/* �����t���O */
/*       2014-02-11 ����őΉ� START */
	K_ASSET_CODE	CHAR(20)	DEFAULT '                    '	NOT NULL,	/** ����ȖڃR�[�h **/
/*       2014-02-11 ����őΉ� STOP */
	KUGIRI_5	CHAR(40)	,	/* KUGIRI_5 */
/*       2014-02-11 ����őΉ� START */
	S_ITEM_FLAG	CHAR(1)		NOT NULL,		/* �A�C�e���敪(���Y�j */
	S_USE_DATE	CHAR(8)		NOT NULL,		/* �K�p�J�n��(���Y�j */
	S_TAX_RATE	NUMBER(5,2)	NOT NULL,		/* �ŗ�(���Y�j */
	S_ITEM_FLAG_P	CHAR(1)	DEFAULT ' ',	/* �A�C�e���敪(�O��j */
	S_USE_DATE_P	CHAR(8)	DEFAULT '        ',	/* �K�p�J�n��(�O��j */
	S_TAX_RATE_P	NUMBER(5,2)	DEFAULT 0,	/* �ŗ�(�O��j */
/*       2014-02-11 ����őΉ� STOP */
	KUGIRI_6	CHAR(40)	,	/* KUGIRI_6 */
	LAST_UPDATETIME	DATE		NOT NULL,	/* �ŏI�X�V���t���� */
	LAST_UPDATE_ID	CHAR(20)	NOT NULL	/* �ŏI�X�V��ID */
)
TABLESPACE CFRDA01;
