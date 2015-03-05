import java.sql.ResultSet;

String table_name = "FORESTFIRE";

/**
 * @author: Fumeng Yang, Lane Harrison
 * @since: 2014
 */

void controlEvent(ControlEvent theEvent) {
    if (interfaceReady) {
        if (theEvent.isFrom("Temp") ||
            theEvent.isFrom("Humidity") ||
            theEvent.isFrom("Wind")) {
            queryReady = true;
        }

        if (theEvent.isFrom("Close")) {
            closeAll();
        }
    }
}

/**
 * generate and submit a query when mouse is released.
 * don't worry about this method
 */
void mouseReleased() {
    if (queryReady == true) {
        submitQuery();
        queryReady = false;
    }
}


int[] monthOf = new int[12];
int[] dayOf = new int[7];

void submitQuery() {

    // I'm getting the values of the slider here
    float maxTemp = rangeTemp.getHighValue();
    float minTemp = rangeTemp.getLowValue();
    
    float maxHumidity = rangeHumidity.getHighValue();
    float minHumidity = rangeHumidity.getLowValue();
    
    float maxWind = rangeWind.getHighValue();
    float minWind = rangeWind.getLowValue();

    // Integrate the variables into the sql String to make a valid statement
    String sql = "select * from " + table_name + " where Temp >= " + minTemp + " and Temp <= " + maxTemp + 
      " and Humidity >= " + minHumidity + " and Humidity <= " + maxHumidity + 
      " and Wind >= " + minWind + " and Wind <= " + maxWind;
    
    // This is where SQL will store your results
    ResultSet rs = null;

    try {
        // submit the sql query and get a ResultSet from the database
       rs  = (ResultSet) DBHandler.exeQuery(sql);
       //set these arrays to 0 so I can count later
       for(int i=0; i<12; i++){
          monthOf[i]=0;
       }
       for(int i=0; i<7; i++){
          dayOf[i]=0;
       }
       
       //If the query was successful, you can iterate through the results here.
        while (rs.next()) {
            String month = rs.getString("month");
            String day = rs.getString("day");
            int id = rs.getInt("id");
            int temp = rs.getInt("Temp");
            float wind = rs.getFloat("Humidity");
            float humidty = rs.getFloat("Wind");
            System.out.println(id + "\t" + temp + "\t" + wind + "\t" + humidty);
            
            int monthkey = 0;
            int daykey = 0;
            
             for(int i = 0; i < days.length; i++){
              if(days[i] == day){
                daykey = i;
              }
            }
            
            for(int i = 0; i < months.length; i++){
              if(months[i] == month){
                monthkey = i;
              }
            }
            
            switch(daykey){
              case 0: dayOf[0]++;
                          break;
              case 1: dayOf[1]++;
                          break;          
              case 2: dayOf[2]++;
                          break;             
              case 3: dayOf[3]++;
                          break;              
              case 4: dayOf[4]++;
                          break;             
              case 5: dayOf[5]++;
                          break;              
              case 6: dayOf[6]++;
                          break;
            }   
                            
            switch(monthkey){
              case 0: monthOf[0]++;
                          break;
              case 1: monthOf[1]++;
                          break;          
              case 2: monthOf[2]++;
                          break;             
              case 3: monthOf[3]++;
                          break;              
              case 4: monthOf[4]++;
                          break;             
              case 5: monthOf[5]++;
                          break;              
              case 6: monthOf[6]++;
                          break;              
              case 7: monthOf[7]++;
                          break;              
              case 8: monthOf[8]++;
                          break;              
              case 9: monthOf[9]++;
                          break;
              case 10: monthOf[10]++;
                          break;              
              case 11: monthOf[11]++;
                          break;
            }   
            
        }
    } catch (Exception e) {
        // should be a java.lang.NullPointerException here when rs is empty
        e.printStackTrace();
    } finally {
        closeThisResultSet(rs);
    }
}

void closeThisResultSet(ResultSet rs) {
    if(rs == null){
        return;
    }
    try {
        rs.close();
    } catch (Exception ex) {
        ex.printStackTrace();
    }
}

void closeAll() {
    DBHandler.closeConnection();
    frame.dispose();
    exit();
}
