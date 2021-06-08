package com.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public class StatisticService {
	
	public Map<String, List> getComplaintChartData(String date, String statisticType, int dataNumber) {
		Map<String, List> returnData = new HashMap<String, List>();
		List<String> complaintChartLabel = new ArrayList<String>();
		List<Integer> complaintChartData = new ArrayList<Integer>();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		File readFile = new File("C:/Dong-Dong_log/statistics.stat");
		Calendar cal = Calendar.getInstance();
		Date startDate = null;
		try {
			if(statisticType.equals("H")) {
				dateFormat = new SimpleDateFormat("yyyy-MM-dd_HH");
				startDate = dateFormat.parse(date);
				cal.setTime(startDate);
				cal.add(Calendar.HOUR, -(dataNumber-1));
			} else if(statisticType.equals("D")) {
				dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				startDate = dateFormat.parse(date);
				cal.setTime(startDate);
				cal.add(Calendar.DATE, -(dataNumber-1));
			} else if(statisticType.equals("M")) {	
				dateFormat = new SimpleDateFormat("yyyy-MM");
				startDate = dateFormat.parse(date);
				cal.setTime(startDate);
				cal.add(Calendar.MONTH, -(dataNumber-1));
			}
			
			BufferedReader reader = new BufferedReader(new FileReader(readFile));
			String targetDate=null;
			String nextLine=null;
			int thisDateSum=0;
			while((nextLine = reader.readLine())!=null){
				targetDate=dateFormat.format(cal.getTime());
				if(nextLine.contains("["+statisticType+"]"+targetDate)) {
					String [] str = nextLine.split(":");
					complaintChartLabel.add("\""+targetDate+"\"");
					complaintChartData.add(Integer.parseInt(str[1]));
					if(statisticType.equals("H")) {
						cal.add(Calendar.HOUR, 1);
					} else if(statisticType.equals("D")) {
						cal.add(Calendar.DATE, 1);
					} else if(statisticType.equals("M")) {
						cal.add(Calendar.MONTH, 1);
					}
				} else if(statisticType.equals("M")&&nextLine.contains("[H]"+date)) {
					String [] str = nextLine.split(":");
					thisDateSum+=Integer.parseInt(str[1]);
				} else if(statisticType.equals("D")&&nextLine.contains("[H]"+date)) {
					String [] str = nextLine.split(":");
					thisDateSum+=Integer.parseInt(str[1]);
				}
			}
			reader.close();
			
			readFile = new File("C:/Dong-Dong_log/statistics.log");
			reader = new BufferedReader(new FileReader(readFile));
			while((nextLine = reader.readLine())!=null){
				if(nextLine.contains("ComplaintAccept")) {
					thisDateSum++;
				}
			}
			reader.close();
			
			complaintChartLabel.add("\""+date+"\"");
			complaintChartData.add(thisDateSum);
		} catch (Exception e) {
			// TODO: handle exception
		}
		returnData.put("complaintChartLabel", complaintChartLabel);
		returnData.put("complaintChartData", complaintChartData);
		return returnData;
	}
}
