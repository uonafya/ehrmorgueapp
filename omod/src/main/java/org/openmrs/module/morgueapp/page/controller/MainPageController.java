package org.openmrs.module.morgueapp.page.controller;

import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.hospitalcore.model.EhrMorgueQueue;
import org.openmrs.module.hospitalcore.util.DateUtils;
import org.openmrs.module.kenyaui.annotation.AppPage;
import org.openmrs.module.morgueapp.MorgueConstants;
import org.openmrs.module.morgueapp.MorgueQueueSimplifier;
import org.openmrs.ui.framework.page.PageModel;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@AppPage(MorgueConstants.APP_MORGUE_APP)
public class MainPageController {
public void controller(PageModel model){
    HospitalCoreService service = Context.getService(HospitalCoreService.class);
    List<MorgueQueueSimplifier> morgueQueueSimplifierList = new ArrayList<MorgueQueueSimplifier>();
    MorgueQueueSimplifier morgueQueueSimplifier = null;
    for(EhrMorgueQueue ehrMorgueQueue : service.getEhrMorgueQueue()) {
        morgueQueueSimplifier = new MorgueQueueSimplifier();
        morgueQueueSimplifier.setIdentifier(Context.getPatientService().getPatient(ehrMorgueQueue.getPatientId()).getPatientIdentifier().getIdentifier());
        morgueQueueSimplifier.setNames(Context.getPatientService().getPatient(ehrMorgueQueue.getPatientId()).getPerson().getPersonName().getFullName());
        morgueQueueSimplifier.setCauseOfDeath(ehrMorgueQueue.getReasonOfDeath().getDisplayString());
        morgueQueueSimplifier.setCreatedBy(Context.getUserService().getUser(ehrMorgueQueue.getCreatedBy()).getPersonName().getFullName());
        morgueQueueSimplifier.setDateCreated(DateUtils.getDateFromDateAsString(ehrMorgueQueue.getCreatedOn(), "yyyy-MM-dd HH:MM"));
        morgueQueueSimplifier.setDateAndTimeOfDeath(DateUtils.getDateFromDateAsString(ehrMorgueQueue.getDateAndTimeOfDeath(), "yyyy-MM-dd HH:MM"));
        morgueQueueSimplifier.setPatientId(ehrMorgueQueue.getPatientId());
        morgueQueueSimplifier.setQueueId(ehrMorgueQueue.getEhrMorgueQueueId());

        morgueQueueSimplifierList.add(morgueQueueSimplifier);
    }
    model.addAttribute("deadList", morgueQueueSimplifierList);
    model.addAttribute("date", new Date());
    model.addAttribute("capacity", service.getEhrMorgueStrength(null).size());
}

}
