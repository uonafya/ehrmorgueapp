package org.openmrs.module.morgueapp.fragment.controller;

import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.hospitalcore.util.MorgueUtils;
import org.openmrs.ui.framework.fragment.FragmentModel;

public class DischargedBodiesFragmentController {

    public void controller(FragmentModel model) {
        HospitalCoreService hospitalCoreService = Context.getService(HospitalCoreService.class);
        model.addAttribute("dischargedList", hospitalCoreService.getMorgueAdmissionList(null, null, MorgueUtils.BODY_DISCHARGED));

    }
}
