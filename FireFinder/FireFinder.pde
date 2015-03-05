
/**********************************************************************************************
 ********************************Don't modify the code in this file***********************
 ********************************Don't modify the code in this file***********************
 ********************************Don't modify the code in this file***********************
 **********************************************************************************************/

import controlP5.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

ControlP5 cp5;

Range rangeTemp;
Range rangeHumidity;
Range rangeWind;

controlP5.Button bSubmit;
controlP5.Button bClose;

int margin = MIN_INT;
int textSize = 12;
int textSizeSmall = 10;

color mouseOnColor = color(158,202,225);
color mouseOnWarningColor = color(251,106,74);
color notcheckColor = color(210);

color checkedColor = color(54, 144, 192);
color labelColor = color(0);

String[] months = {
    "jan", "feb", "mar", "apr", "may", "jun",
    "jul", "aug", "sep", "oct", "nov", "dec"
};

String[] days = {
    "mon", "tue", "wed", "thu", "fri", "sat", "sun"
};

// I'm initializing the slider ranges for you. Ideally you would do this by querying the database at startup.
float[] rangeTempValue = {2.20, 33.00};  // slider of temp 
float[] rangeHumidityValue = {15.00, 100.00}; // slider of humidity 
float[] rangeWindValue = {0.40, 9.40}; // slider of wind 

boolean queryReady = false;
boolean interfaceReady = false;

void setup() {
    size(int(displayWidth * 0.8), int(displayHeight * 0.8));
    background(245);
    canvasWidth = height;
    margin = int((height * 0.0425));
    
    cp5 = new ControlP5(this);
    rectMode(CORNER);
    ellipseMode(CORNER);
    textAlign(CENTER);
    textSize(textSize);

    //smooth();

    drawRangeTemp();
    drawRangeWind();
    drawRangeHumidity();
    
    drawButton();

    interfaceReady = true;

    frame.addWindowListener(new WindowAdapter() {
        public void windowClosing(WindowEvent we) {
            closeAll();
        }
    });
}

void clearCanvas() {
    fill(255);
    noStroke();
    // This is the white rectangle that you'll draw your visualization on top of.
    rect(0, 0, canvasWidth, canvasWidth);
}

void drawRangeTemp() {
    stroke(labelColor);
    fill(labelColor);

    rangeTemp = cp5.addRange("Temp")
        // disable broadcasting since setRange and setRangeValues will trigger an event
        .setBroadcast(false)
        .setPosition(height + margin, 13 * margin + margin / 2)
        .setSize(int(((width - height) * 0.8)), int((height * 0.035)))
        .setHandleSize(5)
        .setRange(rangeTempValue[0], rangeTempValue[1])
        .setRangeValues(rangeTempValue[0], rangeTempValue[1]) // wait for data
        // after the initialization we turn broadcast back on again
        .setBroadcast(true)
        .setColorActive(mouseOnColor)
        .setColorBackground(notcheckColor)
        .setColorForeground(checkedColor)
        .setColorLabel(labelColor);
}

void drawRangeHumidity() {
    rangeHumidity = cp5.addRange("Humidity")
        // disable broadcasting since setRange and setRangeValues will trigger an event
        .setBroadcast(false)
        .setPosition(height + margin, 16 * margin)
        .setSize((int)((width - height) * 0.8), (int)(height * 0.035))
        .setHandleSize(5)
        .setRange(rangeHumidityValue[0], rangeHumidityValue[1])
        .setRangeValues(rangeHumidityValue[0], rangeHumidityValue[1]) // wait for data
        // after the initialization we turn broadcast back on again
        .setBroadcast(true)
        .setColorActive(mouseOnColor)
        .setColorBackground(notcheckColor)
        .setColorForeground(checkedColor)
        .setColorLabel(labelColor);

}

void drawRangeWind() {
    rangeWind = cp5.addRange("Wind")
        // disable broadcasting since setRange and setRangeValues will trigger an event
        .setBroadcast(false)
        .setPosition(height + margin,
            18 * margin + margin / 2)
        .setSize((int)((width - height) * 0.8), (int)(height * 0.035))
        .setHandleSize(5)
        .setRange(rangeWindValue[0], rangeWindValue[1])
        .setRangeValues(rangeWindValue[0], rangeWindValue[1]) // wait for data
        // after the initialization we turn broadcast back on again
        .setBroadcast(true)
        .setColorActive(mouseOnColor)
        .setColorBackground(notcheckColor)
        .setColorForeground(checkedColor)
        .setColorLabel(labelColor);
}

void drawButton() {
    stroke(labelColor);
    
    bClose = cp5.addButton("Close")
        .setPosition(height + 5 * margin, 21 * margin + margin / 4)
        .setColorBackground(notcheckColor)
        .setColorActive(checkedColor)
        .setColorForeground(mouseOnWarningColor)
        .setSize(int((0.3 * (width - height))), int((height * 0.05)))
        .updateSize();
}

public void destroy() {
    closeAll();
}

public void stop() {
    closeAll();
}
