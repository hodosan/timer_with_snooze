require './timer_with_snooze'

include TimeAlert

alert = Alert.new
alert.setting

go = InputData.input_str_validation("タイマーを起動しますか？(y/n)", 'y')
if go
  alert.ring
end
