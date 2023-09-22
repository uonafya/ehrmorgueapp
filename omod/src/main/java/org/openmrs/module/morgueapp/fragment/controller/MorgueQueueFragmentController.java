package org.openmrs.module.morgueapp.fragment.controller;

import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.ui.framework.fragment.FragmentModel;

public class MorgueQueueFragmentController {

    public void controller(FragmentModel model){
        HospitalCoreService hospitalCoreService = Context.getService(HospitalCoreService.class);
        model.addAttribute("admittedList", hospitalCoreService.getMorgueAdmissionList(null, null));
    }
}
