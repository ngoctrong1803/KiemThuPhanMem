package model;

import java.sql.Date;
import java.sql.Time;

public class TakeAnswer {

    private int userID;
    private int quizID;
    private Date startday;
    private Time starttime;
    private Date endday;
    private Time endtime;
    private int questionID;
    private String answer;

    @Override
    public String toString() {
        return "TakeAnswer{" + "userID=" + userID + ", quizID=" + quizID + ", startday=" + startday + ", starttime=" + starttime + ", endday=" + endday + ", endtime=" + endtime + ", questionID=" + questionID + ", answer=" + answer + '}';
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getQuizID() {
        return quizID;
    }

    public void setQuizID(int quizID) {
        this.quizID = quizID;
    }

    public Date getStartday() {
        return startday;
    }

    public void setStartday(Date startday) {
        this.startday = startday;
    }

    public Time getStarttime() {
        return starttime;
    }

    public void setStarttime(Time starttime) {
        this.starttime = starttime;
    }

    public Date getEndday() {
        return endday;
    }

    public void setEndday(Date endday) {
        this.endday = endday;
    }

    public Time getEndtime() {
        return endtime;
    }

    public void setEndtime(Time endtime) {
        this.endtime = endtime;
    }

    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public TakeAnswer(int userID, int quizID, Date startday, Time starttime, Date endday, Time endtime, int questionID, String answer) {
        this.userID = userID;
        this.quizID = quizID;
        this.startday = startday;
        this.starttime = starttime;
        this.endday = endday;
        this.endtime = endtime;
        this.questionID = questionID;
        this.answer = answer;
    }

    public TakeAnswer(int userID, int quizID, Date startday, Time starttime) {
        this.userID = userID;
        this.quizID = quizID;
        this.startday = startday;
        this.starttime = starttime;
    }

    public TakeAnswer() {
    }
}
