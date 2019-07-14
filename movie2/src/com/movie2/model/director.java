package com.movie2.model;

import java.util.ArrayList;
import java.util.Comparator;

public class director {
    private String name;
    private int movies;
    private double scores;

    public int getMovies() {
        return movies;
    }

    public void setMovies(int movies) {
        this.movies = movies;
    }

    public double getScores() {
        return scores;
    }

    public void setScores(double scores) {
        this.scores = scores;
    }

    //private ArrayList<Float> movies = new ArrayList<Float>();
    private double avg;

    public director(String name) {
        this.name = name;
        scores = 0.0;
        movies = 0;
        avg = 0.0;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getAvg() {
        return avg;
    }

    public void setAvg(double avg) {
        this.avg = avg;
    }

    public void calAvg(){
        avg = scores/movies;
    }

    public static class sortByAVG implements Comparator {

        public int compare(Object o1, Object o2) {
            if(((director)o1).getAvg()<((director)o2).getAvg())
                return 1;
            return -1;
        }

    }
}
