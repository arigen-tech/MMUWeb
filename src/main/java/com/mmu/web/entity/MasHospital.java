package com.mmu.web.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


/**
 * The persistent class for the MAS_HOSPITAL database table.
 * 
 */
@Entity
@Table(name="MAS_HOSPITAL")
@NamedQuery(name="MasHospital.findAll", query="SELECT m FROM MasHospital m")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@SequenceGenerator(name="MAS_HOSPITAL_HOSPITALID_GENERATOR", sequenceName="MAS_HOSPITAL_SEQ",allocationSize=1)
public class MasHospital implements Serializable {
	private static final long serialVersionUID = -8647496571766655879L;

	@Id	
	@GeneratedValue(strategy=GenerationType.AUTO, generator="MAS_HOSPITAL_HOSPITALID_GENERATOR")
	@Column(name="HOSPITAL_ID")
	private long hospitalId;

/*	private String address;

	@Column(name="COMMAND_ID")
	private BigDecimal commandId;

	@Column(name="CONTACT_NUMBER")
	private String contactNumber;*/

//	@Column(name="DISTRICT_ID")
//	private BigDecimal districtId;

	@Column(name="HOSPITAL_CODE")
	private String hospitalCode;

	@Column(name="HOSPITAL_NAME")
	private String hospitalName;

	@Temporal(TemporalType.DATE)
	@Column(name="LAST_CHG_DATE")
	private Date lastChgDate;
	
	@Column(name="STATUS")
	private String status;
	
	@Column(name="UNIT_ID")
	private long unitId;
	
	@ManyToOne
	@JoinColumn(name = "UNIT_ID",nullable=false,insertable=false,updatable=false)
	@JsonBackReference
	private MasUnit masUnit;

	public long getHospitalId() {
		return hospitalId;
	}

	public void setHospitalId(long hospitalId) {
		this.hospitalId = hospitalId;
	}

/*	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public BigDecimal getCommandId() {
		return commandId;
	}

	public void setCommandId(BigDecimal commandId) {
		this.commandId = commandId;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}*/

/*	public BigDecimal getDistrictId() {
		return districtId;
	}

	public void setDistrictId(BigDecimal districtId) {
		this.districtId = districtId;
	}*/

	public String getHospitalCode() {
		return hospitalCode;
	}

	public void setHospitalCode(String hospitalCode) {
		this.hospitalCode = hospitalCode;
	}

	public String getHospitalName() {
		return hospitalName;
	}

	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}

	public Date getLastChgDate() {
		return lastChgDate;
	}

	public void setLastChgDate(Date lastChgDate) {
		this.lastChgDate = lastChgDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public long getUnitId() {
		return unitId;
	}

	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

	public MasUnit getMasUnit() {
		return masUnit;
	}

	public void setMasUnit(MasUnit masUnit) {
		this.masUnit = masUnit;
	}

}