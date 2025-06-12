//mysql -u kashinou -p kashinou_db
/*
 *  - One row in the DB = one class (weekday + period + subject)
 *  - Unique index on (day, period) prevents duplicate slots
 *  - no delete, just overwrite
 *  - Keys(not useful at all):
 *      •  S  : overwrite the whole table in the DB
 *      •  L  : reload table from the DB, discarding local edits
 *      • ESC : quit
 */

import java.awt.*;
import javax.swing.*;
import de.bezier.data.sql.*;

final int ROWS  = 7;
final int COLS  = 7;
final int CELLW = 200;
final int CELLH = 50;
final color BG  = color(255);
final color FG  = color(0);

/* ---------- local timetable (5 periods × 5 days) ---------- */
String[][] subjects = new String[5][5];          // [period-1][dayIdx]
String[] days = {"", "", "Mon", "Tue", "Wed", "Thu", "Fri"}; // two blanks for top-left area

// DB
MySQL  mysql;
String DB_HOST = "35.78.25.26";
String DB_NAME = "kashinou_db";
String DB_USER = "kashinou";
String DB_PASS = "";

/* ----------input panel ---------- */
JPanel     panel = new JPanel();
JTextField tfDay = new JTextField();
JTextField tfPer = new JTextField();
JTextField tfSub = new JTextField();

void settings() {
    size(COLS * CELLW, ROWS * CELLH);
}

void setup() {
    mysql = new MySQL(this, DB_HOST, DB_NAME, DB_USER, DB_PASS);
    if (!mysql.connect()) {
        println("DB connection failed.");
        exit();
    }

    // create/ensure table exists
    mysql.query(
        "CREATE TABLE IF NOT EXISTS timetable (" +
        "  id INT AUTO_INCREMENT PRIMARY KEY," +
        "  day CHAR(3) NOT NULL," +
        "  period TINYINT NOT NULL," +
        "  subject VARCHAR(64) NOT NULL," +
        "  UNIQUE KEY(day, period)" +
        ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;"
        );

    clearSubjects();
    loadScheduleFromDB();

    // build dialog
    panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
    panel.add(new JLabel("Day (Mon-Fri)"));
    panel.add(tfDay);
    panel.add(new JLabel("Period (1-5)"));
    panel.add(tfPer);
    panel.add(new JLabel("Subject"));
    panel.add(tfSub);

    drawEmpty();
    drawSubjects();
}

/* ---------- main loop: one dialog per frame ---------- */
void draw() {
    drawEmpty();
    int ret = JOptionPane.showConfirmDialog(
        null, panel, "Input (ESC to quit)",
        JOptionPane.OK_CANCEL_OPTION, JOptionPane.QUESTION_MESSAGE);

    if (ret == JOptionPane.CANCEL_OPTION) {
        noLoop();
        return;
    }

    String d = tfDay.getText().trim();
    int    p = 0;
    try { p = Integer.parseInt(tfPer.getText().trim()); }
    catch (NumberFormatException e) { /* ignore bad period input */ }
    String s = tfSub.getText().trim();

    int col = dayIdx(d);
    if (col >= 0 && 1 <= p && p <= 5) {
        subjects[p - 1][col] = s;                 // write to local
        saveSlotToDB(d, p, s);                    // write to DB immediately
    }

    drawSubjects();

    // clear text fields for next round
    tfDay.setText("");
    tfPer.setText("");
    tfSub.setText("");
}




//functions
/* ---------- drawing ---------- */
void drawEmpty() {
    background(BG);
    stroke(FG);
    textAlign(CENTER, CENTER);

    for (int c = 0; c < COLS; c++) {
        int x = CELLW / 2 + c * CELLW;
        line(x, CELLH / 2, x, height - CELLH / 2);
        if (c >= 2)
            text(days[c], x - CELLW / 2, CELLH);
    }

    for (int r = 0; r < ROWS; r++) {
        int y = CELLH / 2 + r * CELLH;
        line(CELLW / 2, y, width - CELLW / 2, y);
        if (r >= 2)
            text(str(r - 1), CELLW, y - CELLH / 2);
    }
}

void drawSubjects() {
    fill(FG);
    textSize(36);
    for (int p = 1; p <= 5; p++) {
        for (int c = 0; c < 5; c++) {
            String sub = subjects[p - 1][c];
            text(sub, (c + 2) * CELLW, (p + 1) * CELLH);
        }
    }
}

/* ---------- keyboard shortcuts ---------- */
void keyPressed() {
    if (key == 's' || key == 'S') saveAllToDB();
    if (key == 'l' || key == 'L') {
        clearSubjects();
        loadScheduleFromDB();
        drawEmpty();
        drawSubjects();
    }
}

/* ---------- DB functions ---------- */
void saveSlotToDB(String day, int period, String subject) {
    String sql = "REPLACE INTO timetable(day, period, subject) VALUES (" +
        q(day) + "," + period + "," + q(subject) + ");";
    mysql.query(sql);
}

void saveAllToDB() {
    mysql.query("DELETE FROM timetable;");
    for (int p = 1; p <= 5; p++)
        for (int c = 0; c < 5; c++)
            if (subjects[p - 1][c].length() > 0)
                saveSlotToDB(days[c + 2], p, subjects[p - 1][c]);
    println("Database completely updated.");
}

void loadScheduleFromDB() {
    mysql.query("SELECT day, period, subject FROM timetable;");
    while (mysql.next()) {
        String d = mysql.getString("day");
        int    p = mysql.getInt("period");
        String s = mysql.getString("subject");
        int col = dayIdx(d);
        if (col >= 0 && 1 <= p && p <= 5)
            subjects[p - 1][col] = s;
    }
    println("Schedule loaded from DB.");
}

/* ---------- misc ---------- */
void clearSubjects() {
    for (String[] row : subjects)
        java.util.Arrays.fill(row, "");
}

//-1 : error
int dayIdx(String d) {
    for (int i = 0; i < 5; i++)
        if (days[i + 2].equals(d)) return i;
    return -1;
}

String q(String s) {
    return "'" + s.replace("\\", "\\\\").replace("'", "\\'") + "'";
}
