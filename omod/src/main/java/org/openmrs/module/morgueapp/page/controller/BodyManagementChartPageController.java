package org.openmrs.module.morgueapp.page.controller;

import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.kenyaui.annotation.AppPage;
import org.openmrs.module.morgueapp.MorgueConstants;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

@AppPage(MorgueConstants.APP_MORGUE_APP)
public class BodyManagementChartPageController {

    public void controller(PageModel model, @RequestParam(value = "identifier", required = false) String identifier){

        Patient patient = Context.getPatientService().getPatientByUuid(identifier);

        model.addAttribute("currentPatient", patient);

    }
}
