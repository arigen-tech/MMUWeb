package com.mmu.web.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;



@Entity
@Table(name = "PATIENT")
@NamedQuery(name="Patient.findAll", query="SELECT p FROM Patient p")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@SequenceGenerator(name = "PATIENT_PATIENTID_GENERATOR", sequenceName = "PATIENT_SEQ", allocationSize=1)
public class Patient implements Serializable {

	/**
	 * 
	 */
	// commit  space
	private static final long serialVersionUID = -8830913617899325825L;

	@Id	
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "PATIENT_PATIENTID_GENERATOR")
	@Column(name="PATIENT_ID")
	private Long patientId;

	private String address;

	@Column(name="ADMINISTRATIVE_SEX_ID")
	private Long administrativeSexId;

	@Column(name="BLOOD_GROUP_ID")
	private Long bloodGroupId;

	private String city;

	@Column(name="COMMAND_ID")
	private Long commandId;

	@Temporal(TemporalType.DATE)
	@Column(name="DATE_ME")
	private Date dateMe;

	@Temporal(TemporalType.DATE)
	@Column(name="DATE_OF_BIRTH")
	private Date dateOfBirth;

	private Long duration;

	@Column(name="EMAIL_ID")
	private String emailId;

	@Column(name="EMPLOYEE_CATEGORY_ID")
	private Long employeeCategoryId;

	@Column(name="EMPLOYEE_ID")
	private Long employeeId;

	@Column(name="EMPLOYEE_NAME")
	private String employeeName;

	@Column(name="IDENTIFICATION_NO")
	private String identificationNo;

	@Column(name="IDENTIFICATION_TYPE_ID")
	private Long identificationTypeId;

	@Column(name="MARITAL_STATUS_ID")
	private Long maritalStatusId;

	@Column(name="MEDICAL_CATEGORY_ID")
	private Long medicalCategoryId;

	@Column(name="MOBILE_NUMBER")
	private String mobileNumber;

	@Column(name="NOK1_ADDRESS")
	private String nok1Address;

	@Column(name="NOK1_CONTACT_NO")
	private String nok1ContactNo;

	@Column(name="NOK1_EMAIL_ID")
	private String nok1EmailId;

	@Column(name="NOK1_MOBILE_NO")
	private String nok1MobileNo;

	@Column(name="NOK1_NAME")
	private String nok1Name;

	@Column(name="NOK1_PIN_CODE")
	private long nok1PinCode;

	@Column(name="NOK1_POLICE_STATION")
	private String nok1PoliceStation;

	@Column(name="NOK1_RELATION_ID")
	private Long nok1RelationId;

	@Column(name="NOK2_ADDRESS")
	private String nok2Address;

	@Column(name="NOK2_CONTACT_NO")
	private String nok2ContactNo;

	@Column(name="NOK2_EMAIL_ID")
	private String nok2EmailId;

	@Column(name="NOK2_MOBILE_NO")
	private String nok2MobileNo;

	@Column(name="NOK2_NAME")
	private String nok2Name;

	@Column(name="NOK2_PIN_CODE")
	private String nok2PinCode;

	@Column(name="NOK2_POLICE_STATION")
	private String nok2PoliceStation;

	@Column(name="NOK2_RELATION_ID")
	private Long nok2RelationId;

	

	@Column(name="PATIENT_NAME")
	private String patientName;

	private Long pincode;

	@Column(name="RANK_ID")
	private Long rankId;

	@Column(name="RECORD_OFFICE_ADDRESS_ID")
	private Long recordOfficeAddressId;

	@Column(name="REGISTRATION_TYPE_ID")
	private Long registrationTypeId;

	@Column(name="RELATION_ID")
	private Long relationId;

	@Column(name="RELIGION_ID")
	private Long religionId;

	@Temporal(TemporalType.DATE)
	@Column(name="SERVICE_JOIN_DATE")
	private Date serviceJoinDate;

	@Column(name="SERVICE_NO")
	private String serviceNo;

	@Column(name="SERVICE_STATUS_ID")
	private Long serviceStatusId;

	@Column(name="STATE_ID")
	private Long stateId;

	@Column(name="TRADE_ID")
	private Long tradeId;

	@Column(name="UHID_NO")
	private Long uhidNo;

	@Column(name="UNIT_ID")
	private Long unitId;

	public Long getPatientId() {
		return patientId;
	}

	public void setPatientId(Long patientId) {
		this.patientId = patientId;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Long getAdministrativeSexId() {
		return administrativeSexId;
	}

	public void setAdministrativeSexId(Long administrativeSexId) {
		this.administrativeSexId = administrativeSexId;
	}

	public Long getBloodGroupId() {
		return bloodGroupId;
	}

	public void setBloodGroupId(Long bloodGroupId) {
		this.bloodGroupId = bloodGroupId;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public Long getCommandId() {
		return commandId;
	}

	public void setCommandId(Long commandId) {
		this.commandId = commandId;
	}

	public Date getDateMe() {
		return dateMe;
	}

	public void setDateMe(Date dateMe) {
		this.dateMe = dateMe;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public Long getDuration() {
		return duration;
	}

	public void setDuration(Long duration) {
		this.duration = duration;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public Long getEmployeeCategoryId() {
		return employeeCategoryId;
	}

	public void setEmployeeCategoryId(Long employeeCategoryId) {
		this.employeeCategoryId = employeeCategoryId;
	}

	public Long getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(Long employeeId) {
		this.employeeId = employeeId;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public String getIdentificationNo() {
		return identificationNo;
	}

	public void setIdentificationNo(String identificationNo) {
		this.identificationNo = identificationNo;
	}

	public Long getIdentificationTypeId() {
		return identificationTypeId;
	}

	public void setIdentificationTypeId(Long identificationTypeId) {
		this.identificationTypeId = identificationTypeId;
	}

	public Long getMaritalStatusId() {
		return maritalStatusId;
	}

	public void setMaritalStatusId(Long maritalStatusId) {
		this.maritalStatusId = maritalStatusId;
	}

	public Long getMedicalCategoryId() {
		return medicalCategoryId;
	}

	public void setMedicalCategoryId(Long medicalCategoryId) {
		this.medicalCategoryId = medicalCategoryId;
	}

	public String getMobileNumber() {
		return mobileNumber;
	}

	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public String getNok1Address() {
		return nok1Address;
	}

	public void setNok1Address(String nok1Address) {
		this.nok1Address = nok1Address;
	}

	public String getNok1ContactNo() {
		return nok1ContactNo;
	}

	public void setNok1ContactNo(String nok1ContactNo) {
		this.nok1ContactNo = nok1ContactNo;
	}

	public String getNok1EmailId() {
		return nok1EmailId;
	}

	public void setNok1EmailId(String nok1EmailId) {
		this.nok1EmailId = nok1EmailId;
	}

	public String getNok1MobileNo() {
		return nok1MobileNo;
	}

	public void setNok1MobileNo(String nok1MobileNo) {
		this.nok1MobileNo = nok1MobileNo;
	}

	public String getNok1Name() {
		return nok1Name;
	}

	public void setNok1Name(String nok1Name) {
		this.nok1Name = nok1Name;
	}

	public long getNok1PinCode() {
		return nok1PinCode;
	}

	public void setNok1PinCode(long nok1PinCode) {
		this.nok1PinCode = nok1PinCode;
	}

	public String getNok1PoliceStation() {
		return nok1PoliceStation;
	}

	public void setNok1PoliceStation(String nok1PoliceStation) {
		this.nok1PoliceStation = nok1PoliceStation;
	}

	public Long getNok1RelationId() {
		return nok1RelationId;
	}

	public void setNok1RelationId(Long nok1RelationId) {
		this.nok1RelationId = nok1RelationId;
	}

	public String getNok2Address() {
		return nok2Address;
	}

	public void setNok2Address(String nok2Address) {
		this.nok2Address = nok2Address;
	}

	public String getNok2ContactNo() {
		return nok2ContactNo;
	}

	public void setNok2ContactNo(String nok2ContactNo) {
		this.nok2ContactNo = nok2ContactNo;
	}

	public String getNok2EmailId() {
		return nok2EmailId;
	}

	public void setNok2EmailId(String nok2EmailId) {
		this.nok2EmailId = nok2EmailId;
	}

	public String getNok2MobileNo() {
		return nok2MobileNo;
	}

	public void setNok2MobileNo(String nok2MobileNo) {
		this.nok2MobileNo = nok2MobileNo;
	}

	public String getNok2Name() {
		return nok2Name;
	}

	public void setNok2Name(String nok2Name) {
		this.nok2Name = nok2Name;
	}

	public String getNok2PinCode() {
		return nok2PinCode;
	}

	public void setNok2PinCode(String nok2PinCode) {
		this.nok2PinCode = nok2PinCode;
	}

	public String getNok2PoliceStation() {
		return nok2PoliceStation;
	}

	public void setNok2PoliceStation(String nok2PoliceStation) {
		this.nok2PoliceStation = nok2PoliceStation;
	}

	public Long getNok2RelationId() {
		return nok2RelationId;
	}

	public void setNok2RelationId(Long nok2RelationId) {
		this.nok2RelationId = nok2RelationId;
	}

	public String getPatientName() {
		return patientName;
	}

	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}

	public Long getPincode() {
		return pincode;
	}

	public void setPincode(Long pincode) {
		this.pincode = pincode;
	}

	public Long getRankId() {
		return rankId;
	}

	public void setRankId(Long rankId) {
		this.rankId = rankId;
	}

	public Long getRecordOfficeAddressId() {
		return recordOfficeAddressId;
	}

	public void setRecordOfficeAddressId(Long recordOfficeAddressId) {
		this.recordOfficeAddressId = recordOfficeAddressId;
	}

	public Long getRegistrationTypeId() {
		return registrationTypeId;
	}

	public void setRegistrationTypeId(Long registrationTypeId) {
		this.registrationTypeId = registrationTypeId;
	}

	public Long getRelationId() {
		return relationId;
	}

	public void setRelationId(Long relationId) {
		this.relationId = relationId;
	}

	public Long getReligionId() {
		return religionId;
	}

	public void setReligionId(Long religionId) {
		this.religionId = religionId;
	}

	public Date getServiceJoinDate() {
		return serviceJoinDate;
	}

	public void setServiceJoinDate(Date serviceJoinDate) {
		this.serviceJoinDate = serviceJoinDate;
	}

	public String getServiceNo() {
		return serviceNo;
	}

	public void setServiceNo(String serviceNo) {
		this.serviceNo = serviceNo;
	}

	public Long getServiceStatusId() {
		return serviceStatusId;
	}

	public void setServiceStatusId(Long serviceStatusId) {
		this.serviceStatusId = serviceStatusId;
	}

	public Long getStateId() {
		return stateId;
	}

	public void setStateId(Long stateId) {
		this.stateId = stateId;
	}

	public Long getTradeId() {
		return tradeId;
	}

	public void setTradeId(Long tradeId) {
		this.tradeId = tradeId;
	}

	public Long getUhidNo() {
		return uhidNo;
	}

	public void setUhidNo(Long uhidNo) {
		this.uhidNo = uhidNo;
	}

	public Long getUnitId() {
		return unitId;
	}

	public void setUnitId(Long unitId) {
		this.unitId = unitId;
	}

	
}
