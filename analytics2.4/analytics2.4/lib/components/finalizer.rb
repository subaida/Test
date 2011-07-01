# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
require 'drb'
class Finalizer
  def initialize
    @obj = DRbObject.new(nil, 'druby://localhost:8979') 
    puts "Finalizer Class initializing..."
    sleep(1)
    puts "Finalizer class started"
  end
  def call_stored_data
    @obj.finalize
    sleep(60) 
    puts "Finalize method is calling to recollect the stored data" 
    call_stored_data
  end
end
f=Finalizer.new
f.call_stored_data
