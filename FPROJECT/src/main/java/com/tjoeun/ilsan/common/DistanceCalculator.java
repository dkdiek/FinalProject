package com.tjoeun.ilsan.common;

import java.util.Scanner;

public class DistanceCalculator {
	 public static void main(String[] args) {
	        Scanner scanner = new Scanner(System.in);

	        // 첫 번째 지점의 위도와 경도 입력
	        System.out.print("첫 번째 지점의 위도를 입력하세요: ");
	        double lat1 = Math.toRadians(scanner.nextDouble());

	        System.out.print("첫 번째 지점의 경도를 입력하세요: ");
	        double lon1 = Math.toRadians(scanner.nextDouble());

	        // 두 번째 지점의 위도와 경도 입력
	        System.out.print("두 번째 지점의 위도를 입력하세요: ");
	        double lat2 = Math.toRadians(scanner.nextDouble());

	        System.out.print("두 번째 지점의 경도를 입력하세요: ");
	        double lon2 = Math.toRadians(scanner.nextDouble());

	        // 두 지점 간의 거리 계산
	        double distance = calculateDistance(lat1, lon1, lat2, lon2);

	        System.out.println("두 지점 간의 거리: " + distance + " km");
	    }

	    // Haversine 공식으로 두 지점 간의 거리 계산
	    private static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
	        final double R = 6371; // 지구의 반지름 (단위: km)

	        double dLat = lat2 - lat1;
	        double dLon = lon2 - lon1;

	        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
	                   Math.cos(lat1) * Math.cos(lat2) *
	                   Math.sin(dLon / 2) * Math.sin(dLon / 2);

	        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

	        return R * c;
	    }
}
