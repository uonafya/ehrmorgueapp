package org.openmrs.module.morgueapp.fragment.controller;

import org.apache.commons.lang3.StringUtils;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.hospitalcore.model.MorgueAdmission;
import org.openmrs.module.hospitalcore.util.DateUtils;
import org.openmrs.ui.framework.fragment.FragmentModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;

public class MorgueBioFragmentController {
    public void controller(FragmentModel model, @RequestParam(value = "identifier", required = false) String identifier) {
        HospitalCoreService hospitalCoreService = Context.getService(HospitalCoreService.class);
        Patient deadPatient = null;
        if(StringUtils.isNotBlank(identifier)) {
            deadPatient = Context.getPatientService().getPatientByUuid(identifier);
        }
        MorgueAdmission morgueAdmission = hospitalCoreService.getMorgueAdmissionByPatient(deadPatient);
       model.addAttribute("admission", morgueAdmission);
       model.addAttribute("patient", deadPatient);

       Map<String, String> stringStringMap = new HashMap<String, String>();
       String middleName = "";

       if(morgueAdmission != null) {
           if(StringUtils.isNotBlank(morgueAdmission.getPatient().getMiddleName())) {
               middleName = morgueAdmission.getPatient().getMiddleName();
           }
           stringStringMap.put("Names", morgueAdmission.getPatient().getGivenName()+ " "+morgueAdmission.getPatient().getFamilyName()+" "+middleName);
           stringStringMap.put("Date of Death", DateUtils.getDateFromDateAsString(morgueAdmission.getDateOfDeath(), "yyyy-mm-dd hh:mm"));
           stringStringMap.put("Admission Date", DateUtils.getDateFromDateAsString(morgueAdmission.getDateOfAdmission(), "yyyy-mm-dd hh:mm"));
           stringStringMap.put("Received by", morgueAdmission.getReceivedBy());
           stringStringMap.put("Property with body", morgueAdmission.getPropertyWithBody());
           stringStringMap.put("Identification Tag Number", morgueAdmission.getIdentificationTagNo());
           stringStringMap.put("Brought by", morgueAdmission.getBroughtBy());
           stringStringMap.put("Compartment Number", morgueAdmission.getCompartmentNo());
           stringStringMap.put("Body Type", morgueAdmission.getBodyType());
           stringStringMap.put("Created On", DateUtils.getDateFromDateAsString(morgueAdmission.getCreatedOn(), "yyyy-mm-dd hh:mm"));
           stringStringMap.put("Created by", morgueAdmission.getCreatedBy().getGivenName()+" "+morgueAdmission.getCreatedBy().getFamilyName());

       }
       model.addAttribute("morgueAdmission", stringStringMap);
    }
}
