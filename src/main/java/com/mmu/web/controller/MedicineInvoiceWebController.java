package com.mmu.web.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/medicine")
@RestController
@CrossOrigin
public class MedicineInvoiceWebController {

    @RequestMapping(value = "/captureMedicineInvoice", method = RequestMethod.GET)
    public ModelAndView captureMedicineInvoice(){
        return new ModelAndView("captureMedicineInvoice");
    }
}
