package org.openmrs.module.morgueapp.page.controller;

import org.openmrs.api.context.Context;
import org.openmrs.module.kenyaui.annotation.AppPage;
import org.openmrs.module.morgueapp.MorgueConstants;
import org.openmrs.module.morgueapp.api.MorgueappService;
import org.openmrs.ui.framework.page.PageModel;

import java.util.Date;

@AppPage(MorgueConstants.APP_MORGUE_APP)
public class MainPageController {
public void controller(PageModel model){
    MorgueappService service = Context.getService(MorgueappService.class);
    model.addAttribute("deadList", service.getDeadPeople());
    model.addAttribute("date", new Date());
}

}
