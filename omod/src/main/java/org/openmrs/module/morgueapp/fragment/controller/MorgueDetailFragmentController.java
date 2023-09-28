package org.openmrs.module.morgueapp.fragment.controller;

import org.apache.commons.lang3.StringUtils;
import org.openmrs.Patient;
import org.openmrs.PatientIdentifier;
import org.openmrs.Person;
import org.openmrs.PersonName;
import org.openmrs.api.PatientService;
import org.openmrs.api.PersonService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.hospitalcore.IdentifierTypes;
import org.openmrs.module.hospitalcore.model.EhrMorgueQueue;
import org.openmrs.module.hospitalcore.model.EhrMorgueStrength;
import org.openmrs.module.hospitalcore.model.MorgueAdmission;
import org.openmrs.module.hospitalcore.util.MorgueUtils;
import org.openmrs.module.kenyaemr.api.KenyaEmrService;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.ui.framework.fragment.FragmentModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public class MorgueDetailFragmentController {

    public void controller(FragmentModel model) {
        model.addAttribute("units",Context.getService(HospitalCoreService.class).getEhrMorgueStrength());
    }

    public void enrollBodyDetails(@RequestParam(value = "firstName") String firstName,
                                  @RequestParam(value = "middleName", required = false) String middleName,
                                  @RequestParam(value = "lastName") String lastName,
                                  @RequestParam(value = "sex", required = false) String sex,
                                  @RequestParam(value = "strength", required = false) Integer strength,
                                  @RequestParam(value = "dateOfBirth") Date dateOfBirth,
                                  @RequestParam(value = "maritalStatus", required = false) String maritalStatus,
                                  @RequestParam(value = "deathDate", required = false) Date deathDate,
                                  @RequestParam(value = "placeOfDeath", required = false) String placeOfDeath,
                                  @RequestParam(value = "diagnosis", required = false) String diagnosis,
                                  @RequestParam(value = "description", required = false) String description
                                  ) {
        PersonService personService = Context.getPersonService();
        PatientService patientService = Context.getPatientService();
        HospitalCoreService hospitalCoreService = Context.getService(HospitalCoreService.class);
        //create person object
        PersonName personName = new PersonName();
        personName.setGivenName(firstName);
        personName.setFamilyName(lastName);
        if(StringUtils.isNotBlank(middleName)) {
            personName.setMiddleName(middleName);
        }
        personName.setCreator(Context.getAuthenticatedUser());
        personName.setDateCreated(new Date());

        //create a patient object
        String morgueNumber = hospitalCoreService.generateOpdNumber("3FF91B30-04B8-4B0D-98B3-9295122B5F84", IdentifierTypes.MORGUE);
        PatientIdentifier patientIdentifier = new PatientIdentifier();
        patientIdentifier.setPreferred(true);
        patientIdentifier.setIdentifierType(patientService.getPatientIdentifierTypeByUuid("3FF91B30-04B8-4B0D-98B3-9295122B5F84"));
        patientIdentifier.setIdentifier(morgueNumber);
        patientIdentifier.setCreator(Context.getAuthenticatedUser());
        patientIdentifier.setDateCreated(new Date());
        patientIdentifier.setLocation(Context.getService(KenyaEmrService.class).getDefaultLocation());

        Patient patient = new Patient();
        patient.addIdentifier(patientIdentifier);
        patient.setCreator(Context.getAuthenticatedUser());
        patient.setDateCreated(new Date());
        patient.addName(personName);
        patient.setGender(sex);
        if(strength !=null && dateOfBirth == null) {
            patient.setBirthdateFromAge(strength, new Date());
        }
        if(strength ==null && dateOfBirth != null) {
            patient.setBirthdate(dateOfBirth);
        }
        Patient patient1 = patientService.savePatient(patient);
        //create a morgue queue and save it ready for admission
        EhrMorgueQueue ehrMorgueQueue = new EhrMorgueQueue();
        ehrMorgueQueue.setPatientId(patient1.getPatientId());
        ehrMorgueQueue.setCreatedOn(new Date());
        ehrMorgueQueue.setCreatedBy(Context.getAuthenticatedUser().getUserId());
        if(StringUtils.isNotBlank(diagnosis)) {
            ehrMorgueQueue.setReasonOfDeath(Context.getConceptService().getConceptByName(diagnosis));
        }
        ehrMorgueQueue.setDateAndTimeOfDeath(deathDate);
        ehrMorgueQueue.setStatus(0);
        if(StringUtils.isNotBlank(description)){
            ehrMorgueQueue.setNotes(description);
        }
        if(StringUtils.isNotBlank(placeOfDeath)) {
            ehrMorgueQueue.setPlaceOfBirth(placeOfDeath);
        }
        if(StringUtils.isNotBlank(maritalStatus)) {
            ehrMorgueQueue.setMaritalStatus(maritalStatus);
        }
        ehrMorgueQueue.setStatus(0);

        //save the object in the
        Context.getService(HospitalCoreService.class).saveEhrMorgueQueue(ehrMorgueQueue);

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
        List<PatientIdentifier> patientIdentifierList = Context.getPatientService().getPatientIdentifiers(
                null,
                Arrays.asList(Context.getPatientService().getPatientIdentifierTypeByUuid(
                        "3FF91B30-04B8-4B0D-98B3-9295122B5F84")), null, Arrays.asList(patient), false);
        String morgueNumber = hospitalCoreService.generateOpdNumber("3FF91B30-04B8-4B0D-98B3-9295122B5F84", IdentifierTypes.MORGUE);
        if (patientIdentifierList.isEmpty()) {
            hospitalCoreService.savePatientOpdNumbers(patient, "MORG", "3FF91B30-04B8-4B0D-98B3-9295122B5F84",
                    IdentifierTypes.MORGUE);

        }
        morgueAdmission.setIdentifier(morgueNumber);
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
