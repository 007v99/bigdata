package com.movie2.dao;

import com.movie2.util.dataUtil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class movieTypeDao {

    public ArrayList<String[]> getType() throws SQLException {

        ArrayList<String[]> arr = new ArrayList<String[]>();

        String res=null;
        dataUtil d = new dataUtil();
        Connection con = d.getConnct();
        String sql = "select name,score,time from movie_score";
        Statement state = con.createStatement();
        ResultSet set = state.executeQuery(sql);
        while(set.next()){
            String[] xx = new String[3];
            xx[0] = set.getString(1);
            xx[1] = set.getString(2);
            xx[2] = set.getString(3);
           // System.out.println(xx[0]+"  "+xx[1]+"  "+xx[2]);
            arr.add(xx);
        }

        return arr;

    }

}
