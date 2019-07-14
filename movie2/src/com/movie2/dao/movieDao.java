package com.movie2.dao;

import com.movie2.model.director;
import com.movie2.model.move_year;
import com.movie2.model.movie_type;
import com.movie2.util.dataUtil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class movieDao {

    public HashMap getNum() throws SQLException {
        ArrayList<movie_type> arr = new ArrayList<movie_type>();
        dataUtil du = new dataUtil();
        Connection con = du.getConnct();
        Statement st = con.createStatement();
        String sql = "select * from movie_type";
        ResultSet rs = st.executeQuery(sql);
        HashMap map = new HashMap();
        while(rs.next()){
            String s = rs.getString(1);
            int num = rs.getInt(2);
            String r[] = s.split("/");
            for (String key:r){
                if(!map.containsKey(key)){
                    map.put(key,num);
                }else{
                    int value = (int) map.get(key);
                    value += num;
                    map.put(key,value);
                }
            }
        }
        return map;
    }

    public HashMap<String, director> getAVG() throws SQLException {
        HashMap<String,director> map = new HashMap<>();
        dataUtil du = new dataUtil();
        Connection con = du.getConnct();
        Statement st = con.createStatement();
        String sql = "select * from movie_director";
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            String s = rs.getString(1);
            String name = rs.getString(2);
            if(name!=null){
                director dir;
                if((dir=map.get(name))==null)
                    dir = new director(name);
                dir.setScores(dir.getScores()+Double.valueOf(s));
                dir.setMovies(dir.getMovies()+1);
                map.put(name,dir);
            }
        }
        return map;
    }


    public HashMap getMovieTY() throws SQLException {
        HashMap<String,move_year> map = new HashMap();
        dataUtil du = new dataUtil();
        Connection con = du.getConnct();
        Statement st = con.createStatement();
        String sql="select * from movie_ty";
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()){
            String time = rs.getString(2);
            String type = rs.getString(1);
            String t[] = type.split("/");
            if(time.length()>=4){
                String year = time.substring(0,4);
                if(isNum(year)) {
                    move_year my;
                    if ((my = map.get(year)) == null) {
                        my = new move_year(year);
                        map.put(year, my);
                    }
                    for (String tt : t) {
                        String num;
                        if ((num = (String) my.getType().get(tt)) == null)
                            num = "0";
                        int numb = Integer.valueOf(num);
                        numb++;
                        num = String.valueOf(numb);
                        my.getType().put(tt, num);
                    }
                }
                //map.put(year,my);
            }
        }
        return map;
    }

    public static boolean isNum(String msg){
        if(java.lang.Character.isDigit(msg.charAt(0))){
            return true;
        }
        return false;
    }

    public static void main(String args[]) throws SQLException {
       // new movieDao().getMovieTY();
        HashMap<String,Integer> map = new HashMap();
        //String s = "xx";
        //System.out.println(s.substring(0,5));
        map.put("xx",1);
        int xx = map.get("x");
        System.out.println(xx);

    }
}
