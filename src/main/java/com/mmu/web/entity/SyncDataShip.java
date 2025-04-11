package com.mmu.web.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the SYNC_DATA_SHIP database table.
 * 
 */
@Entity
@Table(name="SYNC_DATA_SHIP")
@NamedQuery(name="SyncDataShip.findAll", query="SELECT s FROM SyncDataShip s")
public class SyncDataShip implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name="APPLY_FOR")
	private String applyFor;

	@Column(name="CLOSE_FLAG")
	private Long closeFlag;

	@Column(name="EXP_COUNT")
	private Long expCount;

	@Column(name="EXP_DATE")
	private Timestamp expDate;

	@Column(name="EXP_STATUS")
	private String expStatus;

	@Column(name="EXP_SYNC_DIR")
	private String expSyncDir;

	@Column(name="EXP_USER_ID")
	private Long expUserId;

	@Column(name="IMP_COUNT")
	private Long impCount;

	@Column(name="IMP_DATE")
	private Timestamp impDate;

	@Column(name="IMP_STATUS")
	private String impStatus;

	@Column(name="IMP_SYNC_DIR")
	private String impSyncDir;

	@Column(name="IMP_USER_ID")
	private Long impUserId;

	@Column(name="LAST_CHG_DATE")
	private Timestamp lastChgDate;

	@Id
	@Column(name="SYNC_ID")
	private Long syncId;

	@Column(name="UNIT_ID")
	private Long unitId;

	public SyncDataShip() {
	}

	public String getApplyFor() {
		return this.applyFor;
	}

	public void setApplyFor(String applyFor) {
		this.applyFor = applyFor;
	}

	public Long getCloseFlag() {
		return this.closeFlag;
	}

	public void setCloseFlag(Long closeFlag) {
		this.closeFlag = closeFlag;
	}

	public Long getExpCount() {
		return this.expCount;
	}

	public void setExpCount(Long expCount) {
		this.expCount = expCount;
	}

	public Timestamp getExpDate() {
		return this.expDate;
	}

	public void setExpDate(Timestamp expDate) {
		this.expDate = expDate;
	}

	public String getExpStatus() {
		return this.expStatus;
	}

	public void setExpStatus(String expStatus) {
		this.expStatus = expStatus;
	}

	public String getExpSyncDir() {
		return this.expSyncDir;
	}

	public void setExpSyncDir(String expSyncDir) {
		this.expSyncDir = expSyncDir;
	}

	public Long getExpUserId() {
		return this.expUserId;
	}

	public void setExpUserId(Long expUserId) {
		this.expUserId = expUserId;
	}

	public Long getImpCount() {
		return this.impCount;
	}

	public void setImpCount(Long impCount) {
		this.impCount = impCount;
	}

	public Timestamp getImpDate() {
		return this.impDate;
	}

	public void setImpDate(Timestamp impDate) {
		this.impDate = impDate;
	}

	public String getImpStatus() {
		return this.impStatus;
	}

	public void setImpStatus(String impStatus) {
		this.impStatus = impStatus;
	}

	public String getImpSyncDir() {
		return this.impSyncDir;
	}

	public void setImpSyncDir(String impSyncDir) {
		this.impSyncDir = impSyncDir;
	}

	public Long getImpUserId() {
		return this.impUserId;
	}

	public void setImpUserId(Long impUserId) {
		this.impUserId = impUserId;
	}

	public Timestamp getLastChgDate() {
		return this.lastChgDate;
	}

	public void setLastChgDate(Timestamp lastChgDate) {
		this.lastChgDate = lastChgDate;
	}

	public Long getSyncId() {
		return this.syncId;
	}

	public void setSyncId(Long syncId) {
		this.syncId = syncId;
	}

	public Long getUnitId() {
		return this.unitId;
	}

	public void setUnitId(Long unitId) {
		this.unitId = unitId;
	}

}