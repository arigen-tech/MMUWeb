package com.mmu.web.dto;

import java.util.Objects;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;


public class CaptureInvoice {
	private Integer sourceOfMedicine;
	private Integer medicalStore;
	private String invoiceDate;
	private String invoiceNum;
	private Long inoviceAmount;
	@JsonInclude(Include.NON_NULL)
	private MultipartFile fileTypeValue;
	private String fileName;
	@JsonInclude(value = Include.NON_NULL)
	private Long invoiceId;
	
	
	public CaptureInvoice(Integer sourceOfMedicine, Integer medicalStore, String invoiceDate, String invoiceNum,
			Long inoviceAmount, MultipartFile fileTypeValue, String fileName, Long invoiceId) {
		super();
		this.sourceOfMedicine = sourceOfMedicine;
		this.medicalStore = medicalStore;
		this.invoiceDate = invoiceDate;
		this.invoiceNum = invoiceNum;
		this.inoviceAmount = inoviceAmount;
		this.fileTypeValue = fileTypeValue;
		this.fileName = fileName;
		this.invoiceId = invoiceId;
	}
	public CaptureInvoice() {
		super();

	}
	public Integer getSourceOfMedicine() {
		return sourceOfMedicine;
	}
	public void setSourceOfMedicine(Integer sourceOfMedicine) {
		this.sourceOfMedicine = sourceOfMedicine;
	}
	public Integer getMedicalStore() {
		return medicalStore;
	}
	public void setMedicalStore(Integer medicalStore) {
		this.medicalStore = medicalStore;
	}
	public String getInvoiceDate() {
		return invoiceDate;
	}
	public void setInvoiceDate(String invoiceDate) {
		this.invoiceDate = invoiceDate;
	}
	public String getInvoiceNum() {
		return invoiceNum;
	}
	public void setInvoiceNum(String invoiceNum) {
		this.invoiceNum = invoiceNum;
	}
	public Long getInoviceAmount() {
		return inoviceAmount;
	}
	public void setInoviceAmount(Long inoviceAmount) {
		this.inoviceAmount = inoviceAmount;
	}
	public MultipartFile getFileTypeValue() {
		return fileTypeValue;
	}
	public void setFileTypeValue(MultipartFile fileTypeValue) {
		this.fileTypeValue = fileTypeValue;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Long getInvoiceId() {
		return invoiceId;
	}
	public void setInvoiceId(Long invoiceId) {
		this.invoiceId = invoiceId;
	}
	@Override
	public int hashCode() {
		return Objects.hash(invoiceNum, sourceOfMedicine);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CaptureInvoice other = (CaptureInvoice) obj;
		return Objects.equals(invoiceNum, other.invoiceNum) && Objects.equals(sourceOfMedicine, other.sourceOfMedicine);
	}

	
	
	
	
}
