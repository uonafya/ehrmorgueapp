package org.openmrs.module.morgueapp.fragment.controller;

import org.apache.commons.lang.WordUtils;
import org.openmrs.Concept;
import org.openmrs.ConceptAnswer;
import org.openmrs.api.context.Context;
import org.openmrs.ui.framework.fragment.FragmentModel;

import java.util.HashMap;
import java.util.Map;

public class MorgueServicesFragmentController {

    public void controller(FragmentModel model) {
        Concept mortuaryServices = Context.getConceptService().getConceptByUuid("c0f775f5-bcc3-4900-a39e-35069b3a08ef");
        Map<Integer, String> services = new HashMap<Integer, String>();
        for(ConceptAnswer conceptAnswer : mortuaryServices.getAnswers()) {
            services.put(conceptAnswer.getAnswerConcept().getConceptId(), WordUtils.capitalizeFully(conceptAnswer.getAnswerConcept().getDisplayString()));
        }

        model.addAttribute("services", services);
    }
}
