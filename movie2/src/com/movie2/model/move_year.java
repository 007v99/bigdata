package com.movie2.model;

import java.util.HashMap;

public class move_year {
    String year;
    HashMap<String,String> type;

    public move_year(String year) {
        this.year = year;
        type = new HashMap();
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public HashMap getType() {
        return type;
    }

    public void setType(HashMap type) {
        this.type = type;
    }
}
