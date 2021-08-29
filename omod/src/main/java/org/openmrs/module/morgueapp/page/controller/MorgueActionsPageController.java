package org.openmrs.module.morgueapp.page.controller;

import org.openmrs.PersonAttribute;
import org.openmrs.Person;
import org.openmrs.api.context.Context;
import org.openmrs.module.kenyaui.annotation.AppPage;
import org.openmrs.module.morgueapp.MorgueConstants;
import org.openmrs.module.morgueapp.api.MorgueappService;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.ui.framework.page.PageModel;
import org.openmrs.module.kenyaemr.EmrConstants;
import org.springframework.web.bind.annotation.RequestParam;


import java.util.Date;

@AppPage(MorgueConstants.APP_MORGUE_APP)




public class MorgueActionsPageController {
    public void get(
            @RequestParam("personId") Person person,
            PageModel model) {
        model.addAttribute("person", person);


        if (person.getGender().equals("M")) {
            model.addAttribute("gender", "Male");
        } else {
            model.addAttribute("gender", "Female");
        }
        MorgueappService service = Context.getService(MorgueappService.class);


        model.addAttribute("patientCategory", person.getAttribute(Context.getPersonService().getPersonAttributeTypeByUuid("09cd268a-f0f5-11ea-99a8-b3467ddbf779")));
        model.addAttribute("personId", person.getPersonId());
        model.addAttribute("title", "Morgue Actions");
        PersonAttribute givenName, middleName, familyName;

    }
}





