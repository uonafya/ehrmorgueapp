package org.openmrs.module.morgueapp.fragment.controller;

import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.hospitalcore.model.EhrMorgueQueue;
import org.openmrs.module.hospitalcore.model.EhrMorgueStrength;
import org.openmrs.module.hospitalcore.model.MorgueAdmission;
import org.openmrs.module.hospitalcore.util.MorgueUtils;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.ui.framework.fragment.FragmentModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public class MorgueDetailFragmentController {

    public void controller(FragmentModel model) {
        model.addAttribute("units",Context.getService(HospitalCoreService.class).getEhrMorgueStrength());
    }

    public void enrollBodyDetails(@RequestParam(value = "firstName") String firstName,
                                  @RequestParam(value = "middleName") String middleName,
                                  @RequestParam(value = "lastName") String lastName,
                                  @RequestParam(value = "sex") Integer sex,
                                  @RequestParam(value = "strength") String strength,
                                  @RequestParam(value = "dateOfBirth") String dateOfBirth,
                                  @RequestParam(value = "maritalStatus") Integer maritalStatus,
                                  @RequestParam(value = "deathDate") String deathDate,
                                  @RequestParam(value = "placeOfDeath") String placeOfDeath,
                                  @RequestParam(value = "diagnosis") String diagnosis,
                                  @RequestParam(value = "description") String description
                                  ) {
        System.out.println(firstName);
        System.out.println(middleName);
        System.out.println(lastName);
        System.out.println(sex);
        System.out.println(strength);
        System.out.println(dateOfBirth);
        System.out.println(maritalStatus);
        System.out.println(deathDate);
        System.out.println(placeOfDeath);
        System.out.println(diagnosis);
        System.out.println(description);

    }

    public void admitBodyDetails(@RequestParam(value = "patientId") Patient patient,
                                 @RequestParam(value = "dateOfDeath") Date dateOfDeath,
                                 @RequestParam(value = "bodyType") String bodyType,
                                 @RequestParam(value = "dateOfAdmission") Date dateOfAdmission,
                                 @RequestParam(value = "receivedBy") String receivedBy,
                                 @RequestParam(value = "propertyWithBody") String propertyWithBody,
                                 @RequestParam(value = "identificationTagNo") String identificationTagNo,
                                 @RequestParam(value = "broughtBy") String broughtBy,
                                 @RequestParam(value = "compartmentNo") String compartmentNo,
                                 @RequestParam(value = "consent") String consent) {
        HospitalCoreService hospitalCoreService = Context.getService(HospitalCoreService.class);
        MorgueAdmission morgueAdmission = new MorgueAdmission();
        morgueAdmission.setPatient(patient);
        morgueAdmission.setDateOfDeath(dateOfDeath);
        morgueAdmission.setBodyType(bodyType);
        morgueAdmission.setDateOfAdmission(dateOfAdmission);
        morgueAdmission.setReceivedBy(receivedBy);
        morgueAdmission.setPropertyWithBody(propertyWithBody);
        morgueAdmission.setIdentificationTagNo(identificationTagNo);
        morgueAdmission.setBroughtBy(broughtBy);
        morgueAdmission.setCompartmentNo(compartmentNo);
        morgueAdmission.setConsent(consent);
        morgueAdmission.setCreatedBy(Context.getAuthenticatedUser());
        morgueAdmission.setCreatedOn(new Date());
        morgueAdmission.setStatus(MorgueUtils.BODY_ADMITTED);
       MorgueAdmission admission = hospitalCoreService.saveMorgueAdmission(morgueAdmission);
       if (admission.getMorgueAdmissionId() !=null){
           EhrMorgueQueue ehrMorgueQueue =Context.getService(HospitalCoreService.class).getEhrMorgueQueue().stream().filter(queu-> (Objects.equals(queu.getPatientId(), patient.getPatientId()))).collect(Collectors.toList()).get(0);
           if (ehrMorgueQueue !=null) {
               ehrMorgueQueue.setStatus(MorgueUtils.BODY_CLEARED_FOR_ADMISSION);
               hospitalCoreService.saveEhrMorgueQueue(ehrMorgueQueue);
           }
       }


    }
    public void addMorgueUnits(@RequestParam(value = "morgueName") String morgueName,
                                      @RequestParam(value = "description") String description,
                                      @RequestParam(value = "strength") int strength,
                                      @RequestParam(value = "retired") int retired){
        HospitalCoreService hospitalCoreService = Context.getService(HospitalCoreService.class);
        EhrMorgueStrength ehrMorgueStrength = new EhrMorgueStrength();
        ehrMorgueStrength.setMorgueName(morgueName);
        ehrMorgueStrength.setDescription(description);
        ehrMorgueStrength.setStrength(strength);
        ehrMorgueStrength.setRetired(retired);
        ehrMorgueStrength.setCreatedBy(Context.getAuthenticatedUser().getId());
        ehrMorgueStrength.setCreatedOn(new Date());
        hospitalCoreService.saveEhrMorgueStrength(ehrMorgueStrength);

    }
    public List<SimpleObject> fetchUnitDetails(UiUtils uiUtils) {
        HospitalCoreService hospitalCoreService = Context.getService(HospitalCoreService.class);

        List<SimpleObject> units = null;
        List<EhrMorgueStrength> ehrMorgueStrengths = hospitalCoreService.getEhrMorgueStrength();
        units = SimpleObject.fromCollection(ehrMorgueStrengths, uiUtils, "ehrMorgueStrengthId", "morgueName", "description","strength","retired");

        return units;
    }
}
