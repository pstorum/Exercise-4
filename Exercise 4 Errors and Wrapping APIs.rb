# Exercise 5 Part 1 (Exception Handling)
class InvalidBedtimeException < StandardError ; end

class MentalState
  def auditable?
    # true if the external service is online, otherwise false
  end
  def audit!
    # Could fail if external service is offline
  end
  def do_work
    # Amazing stuff...
  end
end

def audit_sanity!(bedtime_mental_state)
  raise InvalidBedtimeException unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

begin
  new_state = audit_sanity!(bedtime_mental_state)
rescue InvalidBedtimeException => e
  puts e.error
end


# Exercise 5 Part 2 (Don't Return Null / Null Object Pattern)

class BedtimeMentalState < MentalState ; end

class MorningMentalState < MentalState ; end

class NullMentalState < MentalState

  def initialize
    @state = 'Unknown Mental State'
  end
end

def audit_sanity(bedtime_mental_state)
  return InvalidBedtimeException unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

begin
  new_state = audit_sanity(bedtime_mental_state)
rescue InvalidBedtimeException => e
  new_state = NullMentalState.new
end

new_state.do_work




# Exercise 5 Part 3 (Wrapping APIs)

require 'candy_service'

class MyCandyMachine()

  def prepare()
    prepare = CandyMachine.prepare()
    return prepare
  end

  def ready()
    ready = CandyMachine.ready()
    return ready
  end

  def make()
    make = CandyMachine.make()
    return make
  end


machine = MyCandyMachine.new
machine.prepare

if machine.ready?
  machine.make!
else
  puts "sadness"
end