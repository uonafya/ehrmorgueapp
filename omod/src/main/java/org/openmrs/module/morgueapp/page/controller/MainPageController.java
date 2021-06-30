package org.openmrs.module.morgueapp.page.controller;

import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.kenyaui.annotation.AppPage;
import org.openmrs.module.morgueapp.MorgueConstants;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.ui.framework.page.PageModel;
import org.openmrs.ui.framework.page.PageRequest;

import java.util.Date;

@AppPage(MorgueConstants.APP_MORGUE_APP)
public class MainPageController {
    public String get(UiSessionContext sessionContext,
                      PageModel pageModel,
                      PageRequest pageRequest,
                      UiUtils ui
    ) {
        pageRequest.getSession();
        pageModel.addAttribute("date" , new Date());
        return null;
    }
}
