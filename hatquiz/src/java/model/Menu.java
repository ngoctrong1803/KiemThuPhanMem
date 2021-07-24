package model;

public class Menu {

    private int menuID;
    private String name;
    private String url;
    private int location; //vị trí

    public Menu() {
    }

    public Menu(int menuID, String name, String url, int location) {
        this.menuID = menuID;
        this.name = name;
        this.url = url;
        this.location = location;
    }

    public Menu(String name, String url, int location) {
        this.name = name;
        this.url = url;
        this.location = location;
    }

    public int getMenuID() {
        return menuID;
    }

    public void setMenuID(int menuID) {
        this.menuID = menuID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getLocation() {
        return location;
    }

    public void setLocation(int location) {
        this.location = location;
    }

}
