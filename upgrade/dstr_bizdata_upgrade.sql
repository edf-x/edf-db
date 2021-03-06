#科目表
CREATE TABLE IF NOT EXISTS `fi_account` (
  `orgId` bigint(15) NOT NULL DEFAULT '0' COMMENT '组织机构id \n[set_org]',
  `id` bigint(15) NOT NULL COMMENT '主键id',
  `parentId` bigint(15) DEFAULT NULL COMMENT '上级会计科目id',
  `grade` tinyint(2) NOT NULL COMMENT '科目级次',
  `isEndNode` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否末级 1末级 0非末级',
  `accountTypeId` bigint(15) DEFAULT NULL COMMENT '会计科目类别id：资产/负债/共同/权益/成本/损益 \n[set_enum_detail]',
  `code` varchar(40) NOT NULL COMMENT '会计科目编码',
  `name` varchar(50) NOT NULL COMMENT '会计科目名称',
  `gradeName` varchar(200) DEFAULT NULL COMMENT '级次名称（含所有上级名）',
  `helpCode` varchar(200) DEFAULT NULL COMMENT '级次名称（含所有上级名）简拼',
  `balanceDirection` bit(1) NOT NULL DEFAULT b'0' COMMENT '余额方向：0借 1贷 ',
  `cashTypeId` bigint(15) NOT NULL COMMENT '现金（类型）id：现金、现金等价物、银行存款、{空} \n[set_enum_detail]',
  `isAuxAccCalc` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否启用辅助核算 1启用 0不启用',
  `isAuxAccDepartment` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否辅助核算：部门 1启用 0不启用',
  `isAuxAccPerson` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否辅助核算：个人 1启用 0不启用',
  `isAuxAccCustomer` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否辅助核算：客户 1启用 0不启用',
  `isAuxAccSupplier` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否辅助核算：供应商 1启用 0不启用',
  `isAuxAccInventory` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否辅助核算：存货 1启用 0不启用',
  `isAuxAccProject` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否辅助核算：项目 1启用 0不启用',
  `isAuxAccBankAccount` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否辅助核算：银行账号 1启用 0不启用',
  `isQuantityCalc` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否启用数量核算 1启用 0不启用\n启用数量核算，则必须启用存货辅助核算',
  `unitId` bigint(15) DEFAULT NULL COMMENT '计量单位id \n[set_unit]',
  `isMultiCalc` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否启用多货币核算 1启用 0不启用',
  `currencyId` bigint(15) DEFAULT NULL COMMENT '币种id \n[set_currency]',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否启用 1启用 0不启用',
  `isSystem` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否系统预置 1系统预置 0用户创建',
  `accountingStandardsId` bigint(15) DEFAULT NULL COMMENT '企业会计准则id：企业会计准则2007/小企业会计准则2013  \n[set_enum_detail]',
  `industryId` bigint(15) DEFAULT NULL COMMENT '行业id：工业/商贸/服务/其他  \n[set_enum_detail]',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间戳',
  `isSmallScaleUse` bit(1) DEFAULT NULL COMMENT '小规模是否使用 1使用 0不使用',
  `bankId` bigint(15) DEFAULT NULL COMMENT '账号ID',
  `isIncidentalAcc` bit(1) DEFAULT b'0' COMMENT '是否附科目',
  `investorId` bigint(15) DEFAULT NULL COMMENT '投资人ID [set_investor]',
  `isAuxAccLevyAndRetreat` bit(1) DEFAULT NULL COMMENT '是否辅助核算：即征即退 1启用 0不启用',
  `isAuxAccInputTax` bit(1) DEFAULT b'0' COMMENT '是否辅助核算：进项税转出 1启用 0不启用',
  PRIMARY KEY (`orgId`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会计科目'
#凭证表
CREATE TABLE IF NOT EXISTS `fi_journal` (
  `id` bigint(15) NOT NULL COMMENT 'ID',
  `orgId` bigint(15) NOT NULL COMMENT 'orgId',
  `docId` bigint(15) NOT NULL DEFAULT '0' COMMENT '凭证ID',
  `docType` varchar(30) DEFAULT NULL COMMENT '凭证类别',
  `currentYear` int(11) NOT NULL COMMENT '年',
  `currentPeriod` int(11) NOT NULL COMMENT '期间',
  `code` varchar(30) DEFAULT NULL COMMENT '凭证编号',
  `origAmountDrSum` decimal(28,12) DEFAULT NULL COMMENT '借方原币合计',
  `origAmountCrSum` decimal(28,12) DEFAULT NULL COMMENT '贷方原币合计',
  `amountDrSum` decimal(28,12) DEFAULT NULL COMMENT '借方本币合计',
  `amountCrSum` decimal(28,12) DEFAULT NULL COMMENT '贷方本币合计',
  `voucherDate` datetime DEFAULT NULL COMMENT '单据日期',
  `makerId` bigint(15) DEFAULT NULL COMMENT '制单人ID',
  `maker` varchar(50) DEFAULT NULL COMMENT '制单人',
  `createTime` datetime DEFAULT NULL COMMENT '创建日期',
  `auditorId` bigint(15) DEFAULT NULL COMMENT '审核人ID',
  `auditor` varchar(50) DEFAULT NULL COMMENT '审核人',
  `auditedDate` datetime DEFAULT NULL COMMENT '审核日期',
  `reviser` varchar(50) DEFAULT NULL COMMENT '修改人',
  `docSourceTypeId` bigint(15) DEFAULT NULL COMMENT '单据来源[set_enum_detail]',
  `SourceVoucherId` bigint(15) DEFAULT NULL COMMENT '来源单据ID',
  `SourceVoucherCode` varchar(50) DEFAULT NULL COMMENT '来源单据Code',
  `isCashFlowed` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否现金流量分配 0否 1是',
  `isQuantityDoc` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否数量凭证 0否 1是',
  `isForeignCurrencyDoc` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否外币凭证 0否 1是',
  `docBusinessType` bigint(15) DEFAULT NULL COMMENT '凭证业务类型[set_enum_detail]',
  `attachedVoucherNum` int(11) DEFAULT '0' COMMENT '所附单据个数',
  `voucherState` bigint(15) DEFAULT NULL COMMENT '单据状态[set_enum_detail]',
  `isModifiedCode` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否手工修改单据编码 0否 1是',
  `cashFlowedState` bit(1) NOT NULL DEFAULT b'0' COMMENT '现金流量分配状态[0未分配 1已分配',
  `isDifference` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否差异 0否 1是',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间戳',
  `summary` varchar(200) DEFAULT NULL COMMENT '摘要[set_Summary]',
  `exchangeRate` decimal(28,12) DEFAULT NULL COMMENT '汇率',
  `auxiliaryCode` varchar(200) DEFAULT NULL COMMENT '辅助项Code',
  `auxiliaryItems` varchar(200) DEFAULT NULL COMMENT '辅助项',
  `origAmountDr` decimal(28,12) DEFAULT NULL COMMENT '借方原币',
  `origAmountCr` decimal(28,12) DEFAULT NULL COMMENT '贷方原币',
  `amountDr` decimal(28,12) DEFAULT NULL COMMENT '借方本币',
  `amountCr` decimal(28,12) DEFAULT NULL COMMENT '贷方本币',
  `quantityDr` decimal(28,12) DEFAULT NULL COMMENT '借方数量',
  `quantityCr` decimal(28,12) DEFAULT NULL COMMENT '贷方数量',
  `price` decimal(28,12) DEFAULT NULL COMMENT '单价',
  `unitid` bigint(15) DEFAULT NULL COMMENT '计量单位id[set_unit]',
  `sequenceNumber` int(11) DEFAULT NULL COMMENT '顺序号',
  `currencyId` bigint(15) DEFAULT NULL COMMENT '币种ID[set_currency]',
  `accountId` bigint(15) DEFAULT NULL COMMENT '科目ID[set_account]',
  `direction` bit(1) DEFAULT b'0' COMMENT '方向：0：借，1:贷',
  `otherSideAccountIds` varchar(3000) DEFAULT NULL COMMENT '对方科目Id集合',
  `departmentId` bigint(15) DEFAULT NULL COMMENT '部门id[set_department]',
  `personId` bigint(15) DEFAULT NULL COMMENT '人员id[set_person]',
  `customerId` bigint(15) DEFAULT NULL COMMENT '客户ID',
  `supplierId` bigint(15) DEFAULT NULL COMMENT '供应商ID',
  `inventoryId` bigint(15) DEFAULT NULL COMMENT '存货id[set_inventory]',
  `projectId` bigint(15) DEFAULT NULL COMMENT '项目ID[set_project]',
  `bankAccountId` bigint(15) DEFAULT NULL COMMENT '账号ID[set_bank_account]',
  `billCode` varchar(20) DEFAULT NULL COMMENT 'Ʊ�ݺ�',
  `billTypeId` bigint(15) DEFAULT NULL COMMENT 'Ʊ������ID',
  `sourceBusinessTypeId` bigint(15) DEFAULT NULL COMMENT 'ҵ������ID',
  `taxRate` decimal(28,12) DEFAULT NULL COMMENT '˰��',
  `isPeriodBegin` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否期初',
  `isAuxAccCalc` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否明细数据',
  `periodBeginOrigAmount` decimal(28,12) DEFAULT NULL COMMENT '期初原币金额',
  `periodBeginAmount` decimal(28,12) DEFAULT NULL COMMENT '期初本币金额',
  `periodBeginQuantity` decimal(28,12) DEFAULT NULL COMMENT '期初数量',
  `sourceFlag` varchar(2) DEFAULT NULL COMMENT '流水账模板中标识取值',
  `InPutTaxDeductId` bigint(15) DEFAULT NULL COMMENT '待抵扣进项税ID',
  `levyAndRetreatId` bigint(15) DEFAULT NULL COMMENT '即征即退ID',
  `inputTaxId` bigint(15) DEFAULT NULL COMMENT '进项转出辅助ID',
  PRIMARY KEY (`orgId`,`id`),
  UNIQUE KEY `uni_fi_journal` (`orgId`,`currentYear`,`currentPeriod`,`code`,`docBusinessType`,`sequenceNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='凭证及明细账'
