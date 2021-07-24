/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class Subject {

    private int subjectID;
    private String subjectName;
    private String subjectIcon;
    private String description;
    private Timestamp createdate;

    public Subject() {
    }

    public Subject(String subjectName, String subjectIcon, String description, Timestamp createdate) {
        this.subjectName = subjectName;
        this.subjectIcon = subjectIcon;
        this.description = description;
        this.createdate = createdate;
    }
  
    public Subject(int subjectID, String subjectName, String subjectIcon, String description, Timestamp createdate) {
        this.subjectID = subjectID;
        this.subjectName = subjectName;
        this.subjectIcon = subjectIcon;
        this.description = description;
        this.createdate = createdate;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getSubjectIcon() {
        return subjectIcon;
    }

    public void setSubjectIcon(String subjectIcon) {
        this.subjectIcon = subjectIcon;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Timestamp createdate) {
        this.createdate = createdate;
    }

}
