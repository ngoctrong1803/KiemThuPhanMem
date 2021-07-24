package model;

public class CountDownTHPT {

    private int countDownID;
    private int year;
    private String startDay;
    private String note;

    public CountDownTHPT() {
    }

    public CountDownTHPT(int countDownID, int year, String startDay, String note) {
        this.countDownID = countDownID;
        this.year = year;
        this.startDay = startDay;
        this.note = note;
    }

    public CountDownTHPT(int year, String startDay, String note) {
        this.year = year;
        this.startDay = startDay;
        this.note = note;
    }

    public int getCountDownID() {
        return countDownID;
    }

    public void setCountDownID(int countDownID) {
        this.countDownID = countDownID;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getStartDay() {
        return startDay;
    }

    public void setStartDay(String startDay) {
        this.startDay = startDay;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
