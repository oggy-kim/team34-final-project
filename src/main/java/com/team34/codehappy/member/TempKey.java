package com.team34.codehappy.member;

import java.util.Random;

public class TempKey {
	private int size;
    private boolean lowerCheck;
    
    public String getKey(int size, boolean lowerCheck) {
        this.size = size;
        this.lowerCheck = lowerCheck;
        return init();
    }

    private String init() {
        Random random = new Random();
        StringBuffer str = new StringBuffer();
        int num = 0;

        do {
            num = random.nextInt(75) + 48;
            if (isAbleRandom(num)){
                str.append((char)num);
            } else {
                continue;
            }
        } while (str.length() < size);

        if(lowerCheck)
            return str.toString().toLowerCase();
        return str.toString();
    }

    private boolean isAbleRandom(int random) {
        return (random >= 48 && random <= 57) || (random >= 65 && random <= 90) || (random >= 97 && random <= 122);
    }
}
