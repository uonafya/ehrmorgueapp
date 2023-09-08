package org.openmrs.module.morgueapp;

public class MorgueQueueSimplifier {

    private String names;
    private String identifier;
    private Integer patientId;
    public String getNames() {
        return names;
    }

    public void setNames(String names) {
        this.names = names;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public String getDateAndTimeOfDeath() {
        return dateAndTimeOfDeath;
    }

    public void setDateAndTimeOfDeath(String dateAndTimeOfDeath) {
        this.dateAndTimeOfDeath = dateAndTimeOfDeath;
    }

    public String getCauseOfDeath() {
        return causeOfDeath;
    }

    public void setCauseOfDeath(String causeOfDeath) {
        this.causeOfDeath = causeOfDeath;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(String dateCreated) {
        this.dateCreated = dateCreated;
    }

    private String dateAndTimeOfDeath;

    private String causeOfDeath;

    private String createdBy;

    private String dateCreated;
    public Integer getPatientId() {
        return patientId;
    }
    public void setPatientId(Integer patientId) {
        this.patientId = patientId;
    }
}
