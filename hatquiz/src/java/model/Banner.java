package model;

import java.sql.Timestamp;

public class Banner {
    private int bannerID;
    private String content;
    private String image;
    private Timestamp createdate;

    public Banner() {
    }

    public Banner(int bannerID, String content, String image, Timestamp createdate) {
        this.bannerID = bannerID;
        this.content = content;
        this.image = image;
        this.createdate = createdate;
    }

    public Banner(String content, String image, Timestamp createdate) {
        this.content = content;
        this.image = image;
        this.createdate = createdate;
    }

    public int getBannerID() {
        return bannerID;
    }

    public void setBannerID(int bannerID) {
        this.bannerID = bannerID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Timestamp getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Timestamp createdate) {
        this.createdate = createdate;
    }
    
}
