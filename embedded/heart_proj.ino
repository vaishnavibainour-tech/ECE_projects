#include <LiquidCrystal.h>
LiquidCrystal lcd(7, 6, 5, 4, 3, 2);

#include <DHT.h>
#define DHTPIN 11
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);
const int beats = 12;
const int BUZ = 9;
const int STRT = 8;
const int RLY = 10;

int t = 0;
int count = 0;
int i = 0;
int j = 0;
int ppp = 0;
void setup() {

  lcd.begin(16, 2);
  lcd.setCursor(0, 0);
  lcd.print("TEMPERATURE:    ");
  lcd.setCursor(0, 1);
  lcd.print("PULSES:         ");
  Serial.begin(9600);

  pinMode(beats, INPUT);
  pinMode(BUZ, OUTPUT);
  pinMode(RLY, OUTPUT);
  pinMode(STRT, INPUT);
  digitalWrite(STRT, HIGH);
  digitalWrite(RLY, LOW);
  digitalWrite(BUZ, LOW);
  dht.begin();
  Serial.begin(9600);
  Serial.println("WELCOME");
wait:
  if (digitalRead(STRT) == HIGH) {
    goto wait;
  }
  Serial.println("SENSORS READING....");
}
void loop() {
home:
  for (j = 0; j <= 140; j++) {
    t = dht.readTemperature();
    lcd.setCursor(13, 0);
    lcd.print(t);
    lcd.setCursor(15, 0);
    lcd.print("C");

    if (digitalRead(beats) == LOW) {
      ppp = 1;
    }
    delay(100);
    if (digitalRead(beats) == HIGH) {
      if (ppp == 1) {
        count = count + 1;
        lcd.setCursor(7, 1);
        lcd.print(count);
        ppp = 0;
      }
    }
    delay(100);
  }

  count = count * 2;
  lcd.setCursor(7, 1);
  lcd.print(count);
  Serial.print("TEMPERATURE=");
  Serial.print(t);
  Serial.println('C');
  if (count < 40) {
    lcd.setCursor(11, 1);
    lcd.print("AB HB");
    digitalWrite(BUZ, HIGH);
    digitalWrite(RLY, HIGH);
    Serial.print("ALERT,ABNORMAL HEARTBEAT,BPM:");
    Serial.println(count);
    delay(10000);
    digitalWrite(RLY, LOW);
    digitalWrite(BUZ, LOW);
    lcd.setCursor(0, 1);
    lcd.print("PULSES:         ");
    count = 0;
  } else {
    lcd.setCursor(11, 1);
    lcd.print("NRML ");
    Serial.print("NORMAL BPM:");
    Serial.println(count);
    delay(2000);
    lcd.setCursor(0, 1);
    lcd.print("PULSES:         ");
    count = 0;
  }



  /////////////////////////////////////////////////////////////////////////////////        
}
