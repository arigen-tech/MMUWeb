package com.mmu.web.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jdk.nashorn.internal.ir.annotations.Immutable;

/**
 * The persistent class for the VU_MAS_UNIT database table.
 * 
 */
@SuppressWarnings("restriction")
@Entity
@Immutable
@Table(name="VU_MAS_UNIT")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class MasUnit implements Serializable {

	private static final long serialVersionUID = 5010107093035370094L;

	@Id	
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "UNIT_ID",updatable = false, nullable = false)
	private Long unitId;
	
	@Column(name = "UNIT_CODE")
	private String unitCode;
	
	@Column(name = "UNIT_NAME")
	private String unitName;

	public MasUnit() {
	}

	public Long getUnitId() {
		return this.unitId;
	}

	public void setUnitId(Long unitId) {
		this.unitId = unitId;
	}

	
	public String getUnitName() {
		return this.unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public String getUnitCode() {
		return unitCode;
	}

	public void setUnitCode(String unitCode) {
		this.unitCode = unitCode;
	}

	
	

}