package com.mmu.web.entity;

import java.io.Serializable;
import java.math.BigDecimal;
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


/**
 * The persistent class for the USERS database table.
 * 
 */
@Entity
@Table(name="USERS")
@NamedQuery(name="Users.findAll", query="SELECT u FROM Users u")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@SequenceGenerator(name="USERS_SEQ", sequenceName="USERS_SEQ",allocationSize=1)
public class Users implements Serializable {
	private static final long serialVersionUID = -863915371702584702L;

	@Id	
	@GeneratedValue(strategy=GenerationType.AUTO, generator="USERS_SEQ")
	@Column(name="USER_ID")
	private long userId;

	@Column(name="COUNT_USER")
	private BigDecimal countUser;

	

	@Column(name="EMAIL_ADDRESS")
	private String emailAddress;

	@Column(name="FIRST_NAME")
	private String firstName;
	
	@Column(name="LAST_NAME")
	private String lastName;

	@Column(name="LOGIN_NAME")
	private String loginName;

	private String password;

	@Temporal(TemporalType.DATE)
	@Column(name="RESET_COMPLETE_ON")
	private Date resetCompleteOn;

	@Column(name="RESET_COUNT")
	private BigDecimal resetCount;

	@Column(name="RESET_FLAG")
	private String resetFlag;

	@Temporal(TemporalType.DATE)
	@Column(name="RESET_REQ_ON")
	private Date resetReqOn;

	private String status;

	@Column(name="STATUS_SHA1")
	private String statusSha1;

	@Column(name="USER_NAME")
	private String userName;
	
	@Column(name="SERVICE_NO")
	private String serviceNo;

	
	@Column(name="DESIGNATION_ID")
	private String designationId;
	
	@Column(name="ROLE_ID")
	private String roleId;

	
	
	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public BigDecimal getCountUser() {
		return countUser;
	}

	public void setCountUser(BigDecimal countUser) {
		this.countUser = countUser;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getResetCompleteOn() {
		return resetCompleteOn;
	}

	public void setResetCompleteOn(Date resetCompleteOn) {
		this.resetCompleteOn = resetCompleteOn;
	}

	public BigDecimal getResetCount() {
		return resetCount;
	}

	public void setResetCount(BigDecimal resetCount) {
		this.resetCount = resetCount;
	}

	public String getResetFlag() {
		return resetFlag;
	}

	public void setResetFlag(String resetFlag) {
		this.resetFlag = resetFlag;
	}

	public Date getResetReqOn() {
		return resetReqOn;
	}

	public void setResetReqOn(Date resetReqOn) {
		this.resetReqOn = resetReqOn;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStatusSha1() {
		return statusSha1;
	}

	public void setStatusSha1(String statusSha1) {
		this.statusSha1 = statusSha1;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getServiceNo() {
		return serviceNo;
	}

	public void setServiceNo(String serviceNo) {
		this.serviceNo = serviceNo;
	}

	public String getDesignationId() {
		return designationId;
	}

	public void setDesignationId(String designationId) {
		this.designationId = designationId;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	

}