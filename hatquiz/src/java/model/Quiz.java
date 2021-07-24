package model;

import java.sql.Timestamp;

public class Quiz {

    private int quizID;
    private int subjectID;
    private String subjectName;
    private String quizName;
    private int time;
    private int totalQuestion;
    private String image;
    private Timestamp createdate;

    public Quiz() {
    }

    public Quiz(int quizID, int subjectID, String subjectName, String quizName, int time, int totalQuestion, String image, Timestamp createdate) {
        this.quizID = quizID;
        this.subjectID = subjectID;
        this.subjectName = subjectName;
        this.quizName = quizName;
        this.time = time;
        this.totalQuestion = totalQuestion;
        this.image = image;
        this.createdate = createdate;
    }

    public Quiz(int subjectID, String quizName, int time, int totalQuestion, String image, Timestamp createdate) {
        this.subjectID = subjectID;
        this.quizName = quizName;
        this.time = time;
        this.totalQuestion = totalQuestion;
        this.image = image;
        this.createdate = createdate;
    }

    public Quiz(int quizID, String quizName, int time, int totalQuestion, String image) {
        this.quizID = quizID;
        this.quizName = quizName;
        this.time = time;
        this.totalQuestion = totalQuestion;
        this.image = image;
    }

    public Quiz(int quizID, int subjectID, String quizName, int time, int totalQuestion, String image, Timestamp createdate) {
        this.quizID = quizID;
        this.subjectID = subjectID;
        this.quizName = quizName;
        this.time = time;
        this.totalQuestion = totalQuestion;
        this.image = image;
        this.createdate = createdate;
    }

    public Quiz(int quizID, String subjectName, String quizName, int time, int totalQuestion, String image, Timestamp createdate) {
        this.quizID = quizID;
        this.subjectName = subjectName;
        this.quizName = quizName;
        this.time = time;
        this.totalQuestion = totalQuestion;
        this.image = image;
        this.createdate = createdate;
    }

    public int getQuizID() {
        return quizID;
    }

    public void setQuizID(int quizID) {
        this.quizID = quizID;
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

    public String getQuizName() {
        return quizName;
    }

    public void setQuizName(String quizName) {
        this.quizName = quizName;
    }

    public int getTime() {
        return time;
    }

    public void setTime(int time) {
        this.time = time;
    }

    public int getTotalQuestion() {
        return totalQuestion;
    }

    public void setTotalQuestion(int totalQuestion) {
        this.totalQuestion = totalQuestion;
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
