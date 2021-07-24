/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Admin
 */
public class Administrator {

    private int id;
    private String fullName;
    private String email;
    private String password;
    private Boolean status; 

    public Administrator() {
    }

    public Administrator(int id, String fullName, String email, String password, Boolean status) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.status = status;
    }

    public Administrator(int id, String fullName, String email, String password) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
    }

    public Administrator(String fullName, String email, String password, Boolean status) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.status = status;
    }
    
    public Administrator(String email, String password, Boolean status) {
        this.email = email;
        this.password = password;
        this.status = status;
    }

    public Administrator(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public Administrator(String fullName, String email, String password) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
    
}
