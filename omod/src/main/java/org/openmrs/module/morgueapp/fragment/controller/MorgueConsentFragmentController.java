package org.openmrs.module.morgueapp.fragment.controller;

import org.apache.commons.lang3.StringUtils;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.hospitalcore.model.MorgueAdmission;
import org.openmrs.ui.framework.fragment.FragmentModel;
import org.springframework.web.bind.annotation.RequestParam;

public class MorgueConsentFragmentController {

    public void controller(FragmentModel model, @RequestParam(value = "identifier", required = false) String identifier) {
        HospitalCoreService hospitalCoreService = Context.getService(HospitalCoreService.class);

        Patient patient = Context.getPatientService().getPatientByUuid(identifier);

        MorgueAdmission morgueAdmission = hospitalCoreService.getMorgueAdmissionByPatient(patient);
        String consent = "No Consent given";
        if(morgueAdmission != null && StringUtils.isNotBlank(morgueAdmission.getConsent())) {
            consent = morgueAdmission.getConsent();
        }

        model.addAttribute("consent", consent);
    }
}
