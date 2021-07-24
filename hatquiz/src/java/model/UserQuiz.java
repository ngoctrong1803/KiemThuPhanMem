package model;

import java.sql.Time;
import java.sql.Date;

public class UserQuiz {

    private int userquizID;
    private int userID;
    private int quizID;
    private float score;
    private int totalanswertrue;
    private int totalquestion;
    private Time starttime;
    private Time endtime;
    private Date startday;
    private Date endday;

    private String username;
    private String quizname;
    private int subjectID;
    private String subjectName;
    private int totalQuestions;
    private int time;

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

    public int getTotalQuestions() {
        return totalQuestions;
    }

    public void setTotalQuestions(int totalQuestions) {
        this.totalQuestions = totalQuestions;
    }

    public int getTime() {
        return time;
    }

    public void setTime(int time) {
        this.time = time;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getTotalquestion() {
        return totalquestion;
    }

    public void setTotalquestion(int totalquestion) {
        this.totalquestion = totalquestion;
    }

    public String getQuizname() {
        return quizname;
    }

    public void setQuizname(String quizname) {
        this.quizname = quizname;
    }

    public int getUserquizID() {
        return userquizID;
    }

    public void setUserquizID(int userquizID) {
        this.userquizID = userquizID;
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

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public int getTotalanswertrue() {
        return totalanswertrue;
    }

    public void setTotalanswertrue(int totalanswertrue) {
        this.totalanswertrue = totalanswertrue;
    }

    public Time getStarttime() {
        return starttime;
    }

    public void setStarttime(Time starttime) {
        this.starttime = starttime;
    }

    public Time getEndtime() {
        return endtime;
    }

    public void setEndtime(Time endtime) {
        this.endtime = endtime;
    }

    public Date getStartday() {
        return startday;
    }

    public void setStartday(Date startday) {
        this.startday = startday;
    }

    public Date getEndday() {
        return endday;
    }

    public void setEndday(Date endday) {
        this.endday = endday;
    }

    public UserQuiz() {
    }

    public UserQuiz(int userquizID, int userID, int quizID, float score, int totalanswertrue, Time starttime, Time endtime, Date startday, Date endday) {
        this.userquizID = userquizID;
        this.userID = userID;
        this.quizID = quizID;
        this.score = score;
        this.totalanswertrue = totalanswertrue;
        this.starttime = starttime;
        this.endtime = endtime;
        this.startday = startday;
        this.endday = endday;
    }

}
