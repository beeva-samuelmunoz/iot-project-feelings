
--Represents a servo device.
--Table-based pattern


Servo = {}

function Servo.new(pin_servo, pin_led)
  local self = setmetatable({}, Servo)
  self.pin_servo = pin_servo
  pwm.setup(self.pin_servo, 50, 71) --50 HZ
  self.pin_led = pin_led
  gpio.mode(self.pin_led, gpio.OUTPUT)
  self.tmr = tmr.create()
  self.pre_degrees = False -- Move to pre_degrees before going to degrees (hysteresis servo)
  return self
end

function Servo:move(degrees)
  if 0<=degrees and degrees<=180 then
    pwm.setduty(self.pin_servo, ((degrees/180)*(150-25))+25 ) -- Aproximated
    pwm.start(self.pin_servo)
    tmr.delay(1000000)
    pwm.stop(self.pin_servo)
  end
end

function Servo:restart()
  gpio.write(self.pin_led, gpio.LOW)
  self.tmr:stop()
  if self.pre_degrees then
    self:move(self.pre_degrees)
    self.pre_degrees = False
  end
  tmr.delay(500000)
  self:move(150)
end

function Servo:start_led(ms)
  gpio.write(self.pin_led, gpio.HIGH)
  self.tmr:alarm(ms, tmr.ALARM_SINGLE, function()
    self:restart()
  end)
end

function Servo:pos_0()
  self:restart()
  self:move(0)
  self:start_led(5000)
end

function Servo:pos_1()
  self:restart()
  self:move(28)
  self:start_led(5000)
end

function Servo:pos_2()
  self:restart()
  self:move(48)
  self:start_led(5000)
end

function Servo:pos_3()
  self:restart()
  self:move(70)
  self:start_led(5000)
end

function Servo:pos_4()
  self:restart()
  self:move(93)
  self:start_led(5000)
end

function Servo:pos_5()
  self:restart()
  self.pre_degrees = 90
  self:move(50)
  self:move(119)
  self:start_led(5000)
end

function Servo:pos_6()
  self:move(10)
  self:restart()
  self:start_led(5000)
end


function Servo:dial(feeling)
  self.feelings = {
    ["like"]=self.pos_0,
    ["haha"]=self.pos_1,
    ["love"]=self.pos_2,
    ["wow"]=self.pos_3,
    ["sad"]=self.pos_4,
    ["angry"]=self.pos_5,
    ["beeva"]=self.pos_6,
  }
  func = self.feelings[feeling]
  if func then
    func(self)
    return(True)
  else
    return(False)
  end
end

Servo.__index = Servo
setmetatable(Servo, {
  __call = function (cls, pin_servo, pin_led)
    return cls.new(pin_servo, pin_led)
  end,
})
