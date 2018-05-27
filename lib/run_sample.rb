require 'timer_with_snooze'

include TimerWithSnooze

alert = Alert.new
alert.setting

go = InputData.input_str_validation(I18n.t("start_clock"), 'y')
if go
  alert.ring
end
