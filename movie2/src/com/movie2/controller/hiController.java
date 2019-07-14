package com.movie2.controller;


import com.movie2.dao.movieDao;
import com.movie2.dao.movieTypeDao;
import com.movie2.model.director;
import com.movie2.model.move_year;
import com.movie2.model.movie_score;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.SQLException;
import java.util.*;

@Controller
@RequestMapping("/hi")
public class hiController {

    @RequestMapping("/say")
    public String say(Model model){
        model.addAttribute("name","xxx");
        model.addAttribute("url","http://www.cnblogs.com/wormday/p/8435617.html");

        return "/index.html";
    }


    /*@RequestMapping(value="/test",method = RequestMethod.GET,produces = "application/json")
    @ResponseBody
    public ArrayList<String[]> getAll() throws SQLException {
        movieTypeDao mt = new movieTypeDao();
        ArrayList<String[]> x = mt.getType();
       //movie_type bean = new movie_type();
       // bean.setNum(10);
       // bean.setType("xx");
       // s.put("aaa", bean);
        return x;
    }*/

    @RequestMapping(value="/num",method = RequestMethod.GET,produces = "application/json")
    @ResponseBody
    public HashMap getType() throws SQLException {
        movieDao md = new movieDao();
        HashMap s = md.getNum();
        return s;
    }


    @RequestMapping(value="/ty",method = RequestMethod.GET,produces = "application/json")
    @ResponseBody
    public ArrayList<move_year> getTY() throws SQLException {
        movieDao mt = new movieDao();
        HashMap<String,move_year> mao = mt.getMovieTY();
        ArrayList<move_year> x = new ArrayList<move_year>();
        Iterator iter = mao.entrySet().iterator();
        while (iter.hasNext()) {
            Map.Entry entry = (Map.Entry) iter.next();
            move_year my =(move_year)entry.getValue();
            x.add(my);
        }
        return x;
    }

    @RequestMapping(value="/dir",method = RequestMethod.GET,produces = "application/json")
    @ResponseBody
    public ArrayList<director> getDir() throws SQLException {
        movieDao mt = new movieDao();
        ArrayList<director> list = new ArrayList<>();
        HashMap<String,director> map = mt.getAVG();
        Iterator it = map.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry)it.next();
            director d = (director) entry.getValue();
            if(d.getMovies()>=3) {
                d.calAvg();
                list.add(d);
            }
        }
        director sd = new director("sort");
        Collections.sort(list,new director.sortByAVG());
        System.out.println(list.size());
        return list;
    }


    @RequestMapping(value="/json",method = RequestMethod.GET,produces = "application/json")
    @ResponseBody
    public HashMap hello9() throws SQLException {
        movieTypeDao mt = new movieTypeDao();
        HashMap s = new HashMap();
        ArrayList<String[]> x = mt.getType();
        int i=0;
        for (String a[]:x){
            movie_score bean = new movie_score();
            bean.setName(a[0]);
            bean.setScore(a[1]);
            bean.setTime(a[2]);
            s.put(i,bean);
            i++;
        }
        System.out.println("success");
        return s;
    }

   /* @RequestMapping(value="/movie.do")
    @ResponseBody
    public String get() throws SQLException {
        movieTypeDao mt = new movieTypeDao();
        HashMap s = new HashMap();
        ArrayList<String[]> x = mt.getType();
        int i=0;
        for (String a[]:x){
            movie_score bean = new movie_score();
            bean.setName(a[0]);
            bean.setScore(a[1]);
            bean.setTime(a[2]);
            s.put(i,bean);
            i++;
            System.out.println(i);
        }
        String jsonString = JSON.toJSONString(s);

        return jsonString;
    }*/

}
