package model;

import java.sql.Timestamp;

public class Question {

    private int questionID;
    private int subjectID;
    private int quizID;
    private String content;
    private String qA;
    private String qB;
    private String qC;
    private String qD;
    private String qTrue;
    private Timestamp createdate;

    public Question() {
    }

    public Question(int questionID, int subjectID, int quizID, String content, String qA, String qB, String qC, String qD, String qTrue, Timestamp createdate) {
        this.questionID = questionID;
        this.subjectID = subjectID;
        this.quizID = quizID;
        this.content = content;
        this.qA = qA;
        this.qB = qB;
        this.qC = qC;
        this.qD = qD;
        this.qTrue = qTrue;
        this.createdate = createdate;
    }

    public Question(int subjectID, int quizID, String content, String qA, String qB, String qC, String qD, String qTrue, Timestamp createdate) {
        this.subjectID = subjectID;
        this.quizID = quizID;
        this.content = content;
        this.qA = qA;
        this.qB = qB;
        this.qC = qC;
        this.qD = qD;
        this.qTrue = qTrue;
        this.createdate = createdate;
    }

    public Question(int questionID, String content, String qA, String qB, String qC, String qD, String qTrue, Timestamp createdate) {
        this.questionID = questionID;
        this.content = content;
        this.qA = qA;
        this.qB = qB;
        this.qC = qC;
        this.qD = qD;
        this.qTrue = qTrue;
        this.createdate = createdate;
    }

    public int getQuizID() {
        return quizID;
    }

    public void setQuizID(int quizID) {
        this.quizID = quizID;
    }

    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getqA() {
        return qA;
    }

    public void setqA(String qA) {
        this.qA = qA;
    }

    public String getqB() {
        return qB;
    }

    public void setqB(String qB) {
        this.qB = qB;
    }

    public String getqC() {
        return qC;
    }

    public void setqC(String qC) {
        this.qC = qC;
    }

    public String getqD() {
        return qD;
    }

    public void setqD(String qD) {
        this.qD = qD;
    }

    public String getqTrue() {
        return qTrue;
    }

    public void setqTrue(String qTrue) {
        this.qTrue = qTrue;
    }

    public Timestamp getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Timestamp createdate) {
        this.createdate = createdate;
    }

}
